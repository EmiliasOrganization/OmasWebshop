use rocket::Request;
use rocket::serde::json::Json;
use crate::models::User;


// catchers

#[catch(500)]
pub fn internal_error() -> &'static str {
    "Whoops! Looks like something went wrong. :( "
}

#[catch(404)]
pub fn not_found(req: &Request) -> String {
    format!("Route '{}' not found!  Try something else.", req.uri())
}

// routes

#[post("/register", data = "<body>", format = "json")]
pub async fn create(body: Json<User>) -> Result<String, String>{

    Ok(format!("User {} created", body.username))

}

