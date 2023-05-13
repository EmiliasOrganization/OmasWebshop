use serde::{Deserialize, Serialize};
use crate::schema::users;
use crate::schema::addresses;
use diesel::prelude::*;
use uuid::Uuid;



#[derive(Queryable, Debug, AsChangeset, Insertable, Serialize, Deserialize)]
#[diesel(table_name = users)]
pub struct User{
    pub username: String,
    pub surname: String,
    pub firstname: String,
    pub password: String,
    pub email: String,
}

#[derive(Queryable,  Insertable)]
#[diesel(table_name = addresses)]
pub struct Address{
    pub street: String,
    pub city: String,
    pub state: String,
    pub country: String,
    pub zip: String,
    pub user_id: Uuid,
}

