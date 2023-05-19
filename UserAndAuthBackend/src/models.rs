use serde::{Deserialize, Serialize};
use crate::schema::users;
use crate::schema::addresses;
use diesel::prelude::*;
use utoipa::ToSchema;
use uuid::Uuid;

// Models

#[derive(Queryable, Debug, Serialize, ToSchema, Deserialize)]
pub struct Login {

    #[schema(example = "Jeff")]
    pub username: String,
    #[schema(example = "Ab123!")]
    pub password: String,
}

#[derive(Deserialize, ToSchema, Serialize)]
pub struct User {
    #[schema(example = "Jeff the Chef")]
    pub username: String,
    #[schema(example = "Feffer")]
    pub surname: String,
    #[schema(example = "Jeff")]
    pub firstname: String,
    #[schema(example = "Ab123!")]
    pub password: String,
    #[schema(example = "jeff@chef.net")]
    pub email: String,

    pub address: Address,
}

#[derive(Deserialize, ToSchema,  Serialize)]
pub struct Address {
    #[schema(example = "123 Main St")]
    pub street: String,
    #[schema(example = "New York")]
    pub city: String,
    #[schema(example = "NY")]
    pub state: String,
    #[schema(example = "USA")]
    pub country: String,
    #[schema(example = "12345")]
    pub zip: String,
}

//Table Mapper

#[derive(Queryable, Debug, AsChangeset, Insertable, Serialize, Deserialize)]
#[diesel(table_name = users)]
pub struct UserTable {
    pub username: String,
    pub surname: String,
    pub firstname: String,
    pub password: String,
    pub email: String,
}

#[derive(Queryable,  Insertable)]
#[diesel(table_name = addresses)]
pub struct AddressTable {
    pub street: String,
    pub city: String,
    pub state: String,
    pub country: String,
    pub zip: String,
    pub user_id: Uuid,
}

