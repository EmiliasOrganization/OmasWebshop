use std::env;
use bcrypt::verify;
use diesel::result::Error as DieselError;
use diesel::result::{DatabaseErrorKind};
use rocket::http::{ContentType, Status};
use rocket::serde::json::Json;
use serde_json::{json, Value};
use crate::db::{get_username, store_token, validate_token};
use crate::models::{AddressTable, Login, User, UserTable};
use crate::repository::{create_address, create_user, find_hashed_password, update_verification_status};
use crate::util::{generate_email_token, generate_jwt, hash_password, load_env};
use crate::email::{send_verification_mail};

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
            store_token(&*token, user.username.to_string(), 86400 /* 24 hours */).expect("Cant store token for email verification");
            load_env();

            let ressource_server = env::var("RESSOURCE_SERVER").expect("RESSOURCE_SERVER must be set");
            let maildata = json!({
                "name": &user.firstname,
                "verification_link": ressource_server + &token,
            });
            send_verification_mail(maildata);

            return (Status::Ok, (ContentType::JSON, response))
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
pub async fn verify_email_service(token: String) -> (Status, (ContentType, Value)) {
    let registered = validate_token(&*token).expect("Cant validate token");

    if registered{
        let user:String = get_username(&*token).unwrap_or_default().unwrap_or_else(|| String::new());
        update_verification_status(user);


        return (Status::Ok, (ContentType::JSON, json!({"message": "verified"})))
    }
    else{
        return (Status::NotFound, (ContentType::JSON, json!({"error": "Validation failed"})))
    }

}

pub async fn login_user_service(user_login: Json<Login>) -> Result<String, Status>{

    let credentials = find_hashed_password(&user_login.username);

    match credentials {
        Some(login) => {
            if verify(&user_login.password, &login.password).expect("Error verifying password") {
                if login.verified{
                    let token = generate_jwt(login.username.to_owned()).expect("Cant generate JWT");
                    Ok(json!({"verified": &token}).to_string())
                }
                else{
                    Err(Status::Forbidden)
                }
            } else {
                Err(Status::Unauthorized)
            }
        }
        None => Err(Status::NotFound),
    }
}

pub async fn verify_jwt_service(token: String) -> (Status, (ContentType, Value)) {
    let verified = validate_token(&*token).expect("Cant validate token");

    if verified{
        return (Status::Ok, (ContentType::JSON, json!({"message": "verified"})))
    }
    else{
        return (Status::Unauthorized, (ContentType::JSON, json!({"error": "Validation failed"})))
    }

}