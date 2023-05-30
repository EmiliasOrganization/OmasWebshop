use bcrypt::verify;
use diesel::result::Error as DieselError;
use diesel::result::{DatabaseErrorKind};
use rocket::http::{ContentType, Status};
use rocket::serde::json::Json;
use serde_json::{json, Value};
use crate::models::{AddressTable, Login, User, UserTable};
use crate::repository::{create_address, create_user, find_hashed_password};
use crate::util::hash_password;

pub async fn create_user_service(user: Json<User>) -> (Status, (ContentType, Value)){

    let new_user_entry = UserTable {
        username: user.username.to_string(),
        surname: user.surname.to_string(),
        firstname: user.firstname.to_string(),
        password: hash_password(&user.password).expect("Error hashing password"),
        email: user.email.to_string(),
    };

    let insert_result = create_user(new_user_entry);

    match insert_result
    {
        Ok(insert_result) => {
            let new_address_entry = AddressTable {
                street: user.address.street.to_string(),
                city: user.address.city.to_string(),
                state: user.address.state.to_string(),
                country: user.address.country.to_string(),
                zip: user.address.zip.to_string(),
                user_id: insert_result,
            };

            create_address(new_address_entry);

            let response = json!({
                "username": &user.username,
            });

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

pub async fn login_user_service(user_login: Json<Login>) -> Result<String, Status>{

    let credentials = find_hashed_password(&user_login.username);

    match credentials {
        Some(login) => {
            if verify(&user_login.password, &login.password).expect("Error verifying password") {
                Ok(format!("User {} logged in", login.username))
            } else {
                Err(Status::Unauthorized)
            }
        }
        None => Err(Status::NotFound),
    }
}