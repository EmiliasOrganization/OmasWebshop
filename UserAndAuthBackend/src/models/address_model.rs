use serde::{Deserialize, Serialize};
use crate::schema::addresses;
use diesel::prelude::*;
use utoipa::ToSchema;
use uuid::Uuid;

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

//Database Model

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