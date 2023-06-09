use std::env;
use bcrypt::verify;
use diesel::result::Error as DieselError;
use diesel::result::{DatabaseErrorKind};
use diesel::row::NamedRow;
use rocket::http::{ContentType, Cookie, CookieJar, Status};
use rocket::Request;
use rocket::serde::json::Json;
use serde_json::{json, Value};
use crate::db::{get_username, store_email_token, validate_email_token};
use crate::repository::{create_address, create_user, find_hashed_password, update_verification_status};
use crate::util::{generate_email_token, generate_jwt, hash_password, load_env, validate_jwt_token};
use crate::email::{send_verification_mail};
use crate::models::address_model::AddressTable;
use crate::models::login_model::Login;
use crate::models::user_model::{User, UserTable};
use crate::models::response_model::{DefaultResponse, ResponseWithHeader};


pub async fn register_user_service(user: Json<User>) -> (Status, (ContentType, Value)){

    let new_user_entry = UserTable {
        username: user.username.to_owned(),
        surname: user.surname.to_owned(),
        firstname: user.firstname.to_owned(),
        password: hash_password(&user.password).expect("Error hashing password"),
        email: user.email.to_owned(),
    };

    let insert_result = create_user(new_user_entry);

    match insert_result
    {
        Ok(insert_result) => {
            let new_address_entry = AddressTable {
                street: user.address.street.to_owned(),
                city: user.address.city.to_owned(),
                state: user.address.state.to_owned(),
                country: user.address.country.to_owned(),
                zip: user.address.zip.to_owned(),
                user_id: insert_result,
            };

            create_address(new_address_entry);

            let response = json!({
                "username": &user.username,
            });
            let token = generate_email_token();
            store_email_token(&*token, user.username.to_string(), 86400 /* 24 hours */).expect("Cant store token for email verification");
            load_env();

            let ressource_server = env::var("RESSOURCE_SERVER").expect("RESSOURCE_SERVER must be set");
            let maildata = json!({
                "name": &user.firstname,
                "verification_link": ressource_server + &token,
            });
            send_verification_mail(maildata);

            (Status::Ok, (ContentType::JSON, response))
        }
        Err(DieselError::DatabaseError(kind, info)) => {
            match kind {
                DatabaseErrorKind::UniqueViolation => {
                    let error_message = if let Some(constraint) = info.constraint_name() {

                        match constraint {
                            "users_username_key" => "Username already taken.",
                            "users_email_key" => "Email already taken.",
                            _ => info.constraint_name().unwrap(),
                        }
                    } else {
                        "Unknown unique violation."
                    };

                    (Status::Conflict, (ContentType::JSON, json!({"error": error_message})))
                }
                _ => {
                    (Status::InternalServerError, (ContentType::JSON, json!({"error": "Internal server error."})))
                }
            }
        }
        _ => {
            (Status::InternalServerError, (ContentType::JSON, json!({"error": "Internal server error."})))
        }
    }
}

pub async fn verify_email_service(token: String) -> DefaultResponse {
    let registered = validate_email_token(&*token).expect("Cant validate token");
    let mut email_verified = false;
    let mut status = Status::Unauthorized;

    if registered{
        let user:String = get_username(&*token).unwrap_or_default().unwrap_or_else(|| String::new());
        update_verification_status(user);
        email_verified = true;
        status = Status::Ok;

    }
    DefaultResponse{
        status,
        content_type: ContentType::JSON,
        value: json!({"verified": email_verified})
    }
}

pub async fn login_user_service(user_login: Json<Login>) -> ResponseWithHeader {
    let credentials = find_hashed_password(&user_login.username);
    let mut status = Status::Unauthorized;
    let mut verified = false;
    let mut headers= vec![];

    match credentials {
        Some(login) => {
            if verify(&user_login.password, &login.password).expect("Error verifying password") {
                if login.verified {
                    let token = generate_jwt(login.username.to_owned()).expect("Cant generate JWT");

                    let cookie = Cookie::build("jwt-token", token)
                        .http_only(true)
                        .finish();

                    headers = vec![
                        ("Set-Cookie".to_string(), cookie.to_string()),
                    ];
                    verified = true;
                    status = Status::Ok;
                }
            }
        }
        None => status = Status::InternalServerError

    }
    ResponseWithHeader {
        status,
        headers,
        content_type: ContentType::JSON,
        value: json!({"verified": verified})
    }
}

pub async fn verify_jwt_service(cookies: &CookieJar<'_>) -> DefaultResponse {
    let token_cookie = cookies.get("jwt-token");
    let mut jwt_verified = false;
    let mut status =  Status::Unauthorized;

    match token_cookie
    {
        Some(cookie) => {
            let token = cookie.value();

            if validate_jwt_token(token)
            {
                status = Status::Ok;
                jwt_verified = true;
            }
        }
        _ => {status = Status::NotFound}
    }
    DefaultResponse {
        status,
        content_type: ContentType::JSON,
        value: json!({"verified": jwt_verified})
    }
}

