use diesel::{OptionalExtension, RunQueryDsl, Table};
use rocket::http::Status;
use rocket::Request;
use rocket::serde::json::{Json};
use crate::db::establish_connection;
use crate::models::{Login, User, UserTable};
use crate::service::create_user_service;
use crate::diesel::QueryDsl;
use crate::rocket::futures::StreamExt;
use std::iter::Iterator;
use bcrypt::verify;
use diesel::associations::HasTable;
use uuid::Uuid;
use crate::diesel::ExpressionMethods;
use crate::schema::users::dsl;
use crate::util::hash_password;


// catchers

#[catch(500)]
pub fn internal_error() -> &'static str {
    "Whoops! Looks like we messed up."
}

#[catch(404)]
pub fn not_found(req: &Request) -> String {
    format!("I couldn't find '{}'. Try something else?", req.uri())
}

#[catch(409)]
pub fn conflict() -> &'static str { "Username already exists" }

#[catch(422)]
pub fn missing_entity() -> &'static str { "Invalid input" }


// routes

#[post("/register", data = "<body>", format = "json")]
pub async fn register(body: Json<User>) -> Result<String, Status>{
     create_user_service(body).await
}

#[post("/login", data = "<body>", format = "json")]
pub async fn login(body: Json<Login>) -> Result<String, Status>{

     use crate::schema::users::dsl::*;

     let connection = &mut establish_connection();


    let credentials: Option<Login> = users
        .filter(username.eq(&body.username))
        .select((username, password))
        .first::<(String, String)>(connection)
        .optional()
        .map(|result| {
            match result {
                Some((query_username, query_password)) => Some(Login { username:query_username, password:query_password }),
                None => None, // Handle the case when the username doesn't exist
            }
        })
        .unwrap_or(None);

    match credentials {
        Some(login) => {
            let hashed_password = hash_password(&body.password).expect("Error hashing password");
            if verify(&hashed_password, &login.password).expect("Error verifying password") {
                Ok(format!("User {} logged in", login.username))
            } else {
                // Handle incorrect password
                Err(Status::Unauthorized)
            }
        }
        None => {
            // Handle username not found
            Err(Status::NotFound)
        }
    }
}
