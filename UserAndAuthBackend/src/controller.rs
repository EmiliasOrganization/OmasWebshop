use diesel::associations::HasTable;
use diesel::RunQueryDsl;
use rocket::Request;
use rocket::serde::json::Json;
use uuid::Uuid;
use crate::models::{User};
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
pub async fn register(body: Json<User>) -> Result<String, String>{

    use crate::schema::users::dsl::*;

    let connection = &mut establish_connection();

     let new_user = User{
         username: body.username.to_string(),
         surname: body.surname.to_string(),
         firstname: body.firstname.to_string(),
         password: body.password.to_string(),
         email: body.email.to_string(),
     };

    let new_id = diesel::insert_into(users::table())
        .values(new_user)
        .returning(id)
        .get_result::<Uuid>(connection)
        .expect("Error saving new user");


    // let user = users::table.find(body.username.to_string())
    //     .first::<DbUser>(connection)
    //     .expect("Error loading user");

    Ok(format!("User {} created", new_id.to_string()))
}

