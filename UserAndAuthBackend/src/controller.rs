use rocket::http::{CookieJar};
use rocket::Request;
use rocket::serde::json::{Json};
use crate::models::login_model::Login;
use crate::models::response_model::{DefaultResponse, ResponseWithHeader};
use crate::models::user_model::User;
use crate::services::login_jwt_service::{login_user_service, verify_jwt_service};
use crate::services::registration_service::{register_user_service, verify_email_service};


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
    tag = "User Operations",
    context_path = "/api/user",
    request_body = User,
    responses(
    (status = 200, description = "User created successfully", body = (String, String), example = json!({"username": "Jeff the Chef"})),
    (status = 409, body = String, description = "Username is already taken", example = json!("Username already exists")),
    (status = 500, body = String, description = "Server Error", example = json!("Whoops! Looks like we messed up.")),
    (status = 422, body = String, description = "JSON incorrect", example = json!("Invalid input"))
    )
)]
#[post("/register", data = "<body>", format = "json")]
pub async fn register(body: Json<User>) -> DefaultResponse
{
     register_user_service(body).await
}

#[utoipa::path(
    tag = "Authentication",
    context_path = "/api/auth",
    request_body = Login,
    responses(
        (status = 200, description = "Login successful", body = Address),
        (status = 404, body = String, description = "User not found", example = json!("User not found !")),
        (status = 500, body = String, description = "Server Error",  example = json!("Whoops! Looks like we messed up.")),
        (status = 422, body = String, description = "JSON incorrect", example = json!("Invalid input"))
    )
)]
#[post("/login", data = "<body>", format = "json")]
pub async fn login(body: Json<Login>) -> ResponseWithHeader
{
    login_user_service(body).await
}


#[utoipa::path(
    tag = "User Operations",
    context_path = "/api/auth",
    responses(
        (status = 200, description = "Verification successful", body = String),
        (status = 500, body = String, description = "Server Error",  example = json!("Whoops! Looks like we messed up.")),
        (status = 422, body = String, description = "JSON incorrect", example = json!("Invalid input"))
    )
)]
#[get("/register/verify/<token>")]
pub async fn verify_email(token: String) -> DefaultResponse { verify_email_service(token).await }

#[utoipa::path(
    tag = "User Operations",
    context_path = "/api/user",
    responses(
        (status = 200, description = "User found", body = String),
        (status = 404, body = String, description = "User not found", example = json!("User not found !")),
        (status = 500, body = String, description = "Server Error",  example = json!("Whoops! Looks like we messed up.")),
        (status = 422, body = String, description = "JSON incorrect", example = json!("Invalid input"))
    )
)]
#[post("/jwt")]
pub async fn verify_jwt(cookies: &CookieJar<'_>) -> DefaultResponse { verify_jwt_service(cookies).await }


