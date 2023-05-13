use serde::{Deserialize, Serialize};
use crate::schema::users;
use diesel::prelude::*;

#[allow(non_snake_case)]
#[derive(Debug, Deserialize, Serialize, Clone, Insertable)]
#[table_name = "users"]
pub struct NewUser<'a>{
    pub username: &'a str,
    pub surname: &'a str,
    pub firstname: &'a str,
    pub email: &'a str,
}

#[derive(Queryable, Debug, AsChangeset)]
pub struct User{
    pub id: i32,
    pub username: String,
    pub surname: String,
    pub firstname: String,
    pub email: String,
}