use std::env;
use diesel::result::DatabaseErrorKind;
use rocket::http::{ContentType, Status};
use rocket::serde::json::Json;
use serde_json::{json};
use crate::config::{load_env};
use crate::email::send_verification_mail;
use crate::models::address_model::AddressTable;
use crate::models::response_model::DefaultResponse;
use crate::models::user_model::{User, UserTable};
use crate::repository::{create_address, create_user, update_verification_status};
use diesel::result::Error as DieselError;
use crate::utils::email_validation_util::{generate_email_token, get_username, store_email_token, validate_email_token};
use crate::utils::hash_password_util::hash_password;

pub async fn register_user_service(user: Json<User>) -> DefaultResponse{

    let mut status = Status::InternalServerError;
    let mut value = json!({"message": "Some error occurred"});

    let new_user_entry = UserTable {
        username: user.username.to_owned(),
        lastname: user.lastname.to_owned(),
        firstname: user.firstname.to_owned(),
        password: hash_password(&user.password).expect("Error hashing password"),
        email: user.email.to_owned(),
    };

    let insert_result = create_user(new_user_entry);

    match insert_result
    {
        Ok(insert_result) => {
            // let new_address_entry = AddressTable {
            //     street: user.address.street.to_owned(),
            //     city: user.address.city.to_owned(),
            //     state: user.address.state.to_owned(),
            //     country: user.address.country.to_owned(),
            //     zip: user.address.zip.to_owned(),
            //     user_id: insert_result,
            // };
            //
            // create_address(new_address_entry);

            let token = generate_email_token();

            store_email_token(&*token, user.username.to_string(), 86400 /* 24 hours */).expect("Cant store token for email verification");

            load_env();

            let resource_server = env::var("RESSOURCE_SERVER").expect("RESSOURCE_SERVER must be set");
            let maildata = json!({
                "name": &user.firstname,
                "verification_link": resource_server + &token,
            });
            send_verification_mail(maildata);

            status = Status::Ok;
           value = json!({"message": &user.username});

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

                    status = Status::Conflict;
                    value = json!({"message": &error_message});

                }
                _ => {}
            }
        }
        _ => {}
    }
    DefaultResponse{
        status,
        content_type: ContentType::JSON,
        value
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