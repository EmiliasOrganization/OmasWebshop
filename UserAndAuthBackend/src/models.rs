use serde::{Deserialize, Serialize};

#[allow(non_snake_case)]
#[derive(Debug, Deserialize, Serialize, Clone)]
pub struct User{
    pub id: String,
    pub username: String,
    pub surname: String,
    pub firstname: String,
    pub email: String,
}