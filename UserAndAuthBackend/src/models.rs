use serde::{Deserialize, Serialize};

#[allow(non_snake_case)]
#[derive(Debug, Deserialize, Serialize, Clone)]
pub struct User{
    pub id: String,
    pub username: String,
    pub password: String,
    pub address: Address,
    pub surname: String,
    pub firstname: String,
    pub email: String,
}

#[allow(non_snake_case)]
#[derive(Debug, Deserialize, Serialize, Clone)]
pub struct Address{
    pub street: String,
    pub city: String,
    pub state: String,
    pub zip: String,
}

#[derive(Debug, Deserialize, Serialize, Clone)]
pub struct Login{
    pub username: String,
    pub password: String,
}