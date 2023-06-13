use serde::{Deserialize, Serialize};
use crate::schema::users;
use diesel::prelude::*;
use utoipa::ToSchema;
use crate::models::address_model::Address;


#[derive(Deserialize, ToSchema, Serialize)]
pub struct User {
    #[schema(example = "Jeff the Chef")]
    pub username: String,
    #[schema(example = "Feffer")]
    pub lastname: String,
    #[schema(example = "Jeff")]
    pub firstname: String,
    #[schema(example = "Ab123!")]
    pub password: String,
    #[schema(example = "jeff@chef.net")]
    pub email: String,

    // pub address: Address,
}

//Database Model

#[derive(Queryable, Debug, AsChangeset, Insertable, Serialize, Deserialize)]
#[diesel(table_name = users)]
pub struct UserTable {
    pub username: String,
    pub lastname: String,
    pub firstname: String,
    pub password: String,
    pub email: String,
}