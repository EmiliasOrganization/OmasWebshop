use std::env;
use std::path::PathBuf;
use bcrypt::verify;
use diesel::result::Error as DieselError;
use lettre::transport::smtp::authentication::Credentials;
use lettre::{Message, SmtpTransport, Transport};
use diesel::result::{DatabaseErrorKind};
use lettre::message::header;
use rocket::http::{ContentType, Status};
use rocket::serde::json::Json;
use serde_json::{json, Value};
use crate::models::{AddressTable, Login, User, UserTable};
use crate::repository::{create_address, create_user, find_hashed_password};
use crate::util::hash_password;

pub async fn create_user_service(user: Json<User>) -> (Status, (ContentType, Value)){

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

            let email = Message::builder()
                .to("florian-home@web.de".parse().unwrap())
                .from("dasflorix@gmail.com".parse().unwrap())
                .subject("Wilkommen im Webshop")
                .header(header::ContentType::TEXT_HTML)
                .body(format!("<html>
                <body>
                    <h1>Hallo {} ,</h1>
                    <p>Wilkommen auf unserem Webshop.</p>
                    <p>Best regards,</p>
                    <p>Florian</p>
                </body>
            </html>",
                              user.firstname,))
                .unwrap();

            let mut path = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
            path.push("../.env");

            dotenv::from_path(path.as_path()).expect("Failed to load .env file");

            let smtp_username = env::var("SMTP_USERNAME").expect("SMTP_USERNAME must be set");
            let smtp_password = env::var("SMTP_PASSWORD").expect("SMTP_PASSWORD must be set");
            let smtp_server = env::var("SMTP_SERVER").expect("SMTP_SERVER must be set");


            let creds = Credentials::new(smtp_username, smtp_password.to_owned());

            let mail_server = SmtpTransport::relay(&smtp_server)
                .map_err(|_| Status::InternalServerError)
                .unwrap()
                .credentials(creds)
                .build();

            match mail_server.send(&email) {
                Ok(_) => println!("Email sent successfully!"),
                Err(e) => println!("Could not send email: {:?}", e),
            }

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