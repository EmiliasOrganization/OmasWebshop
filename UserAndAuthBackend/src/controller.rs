use diesel::associations::HasTable;
use diesel::{OptionalExtension, QueryResult, RunQueryDsl};
use rocket::http::Status;
use rocket::Request;
use rocket::response::status;
use rocket::response::status::Conflict;
use rocket::serde::json::{Json, to_string};
use uuid::Uuid;
use crate::models::{AddressTable, User, UserTable};
use crate::db::establish_connection;
use crate::diesel::QueryDsl;
use crate::diesel::ExpressionMethods;
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

// routes

#[post("/register", data = "<body>", format = "json")]
pub async fn register(body: Json<User>) -> Result<String, Status>{

    use crate::schema::users::dsl::*;

    let connection = &mut establish_connection();

     let new_user_entry = UserTable {
         username: body.username.to_string(),
         surname: body.surname.to_string(),
         firstname: body.firstname.to_string(),
         password: hash_password(&body.password).expect("Error hashing password"),
         email: body.email.to_string(),
     };

    let insert_result = diesel::insert_into(users)
        .values(&new_user_entry)
        .returning(id)
        .get_result::<Uuid>(connection);

    match insert_result
    {
        Ok(insert_result) => {
            let new_address_entry = AddressTable {
                street: body.address.street.to_string(),
                city: body.address.city.to_string(),
                state: body.address.state.to_string(),
                country: body.address.country.to_string(),
                zip: body.address.zip.to_string(),
                user_id: insert_result,
            };

            diesel::insert_into(crate::schema::addresses::table)
                .values(&new_address_entry)
                .execute(connection)
                .expect("Something went wrong");

            return Ok(format! ("User {} created", &body.username))},
        Err(diesel::result::Error::DatabaseError(db_error, _)) => {
            // Check if the error is due to a duplicate key violation
            if let diesel::result::DatabaseErrorKind::UniqueViolation = db_error {
                Err(Status::Conflict)
            } else {
                Err(Status::InternalServerError)
            }
        }
        _ => Err(Status::InternalServerError),
    }

}

