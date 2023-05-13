use serde::{Deserialize, Serialize};
use crate::schema::users;
use diesel::prelude::*;

#[derive(Queryable, Debug, AsChangeset, Insertable, Serialize, Deserialize)]
#[table_name = "users"]
pub struct User{
    pub username: String,
    pub surname: String,
    pub firstname: String,
    pub password: String,
    pub email: String,
}

#[derive(Queryable, Debug, AsChangeset, Insertable, Serialize, Deserialize)]
#[table_name = "addresses"]
pub struct address{
    pub street: String,
    pub city: String,
    pub state: String,
    pub country: String,
    pub zip: String,
}