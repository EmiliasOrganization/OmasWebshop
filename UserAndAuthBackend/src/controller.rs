use rocket::http::Status;
use rocket::Request;
use rocket::serde::json::{Json};
use crate::models::{Login, User};
use crate::service::{create_user_service, login_user_service};

// catchers

#[catch(500)]
pub fn internal_error() -> &'static str {
    "Whoops! Looks like we messed up."
}

#[catch(404)]
pub fn not_found(req: &Request) -> String { format!("I couldn't find '{}' ", req.uri()) }

#[catch(404)]
pub fn user_not_found() -> &'static str { "User not found !" }

#[catch(409)]
pub fn conflict() -> &'static str { "Username already exists" }

#[catch(422)]
pub fn missing_entity() -> &'static str { "Invalid input" }


// routes

#[utoipa::path(
    context_path = "/api/user",
    request_body = User,
    responses(
        (status = 200, body = User)
    )
)]
#[post("/register", data = "<body>", format = "json")]
pub async fn register(body: Json<User>) -> Result<String, Status>
{
     create_user_service(body).await
}


#[utoipa::path(
    context_path = "/api/auth",
    request_body = Login,
    responses(
        (status = 200, description = "Login successful", body = Address)
    )
)]
#[post("/login", data = "<body>", format = "json")]
pub async fn login(body: Json<Login>) -> Result<String, Status>
{
    login_user_service(body).await
}
