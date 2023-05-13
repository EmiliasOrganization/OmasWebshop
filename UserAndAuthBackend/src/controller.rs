use diesel::RunQueryDsl;
use rocket::Request;
use rocket::serde::json::Json;
use crate::models::{User as DbUser};
use crate::db::establish_connection;


// catchers

#[catch(500)]
pub fn internal_error() -> &'static str {
    "Whoops! Looks like we messed up."
}

#[catch(404)]
pub fn not_found(req: &Request) -> String {
    format!("I couldn't find '{}'. Try something else?", req.uri())
}

// routes

#[post("/register", data = "<body>", format = "json")]
pub async fn register(body: Json<DbUser>) -> Result<String, String>{

    use crate::schema::users::dsl::*;

    let connection = &mut establish_connection();

     let new_user = DbUser{
         username: body.username.to_string(),
         surname: body.surname.to_string(),
         firstname: body.firstname.to_string(),
         password: body.password.to_string(),
         email: body.email.to_string(),
     };


    diesel::insert_into(users)
        .values(new_user)
        .execute( connection)
        .expect("Error saving new user");

    Ok(format!("User {} created", body.username))

}

