use rocket::http::Status;
use rocket::serde::json::Json;
use crate::models::{AddressTable, User, UserTable};
use crate::repository::{create_address, create_user};
use crate::util::hash_password;

pub async fn create_user_service(user: Json<User>) -> Result<String, Status>{

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

            return Ok(format! ("User {} created", &user.username))},

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