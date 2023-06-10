use serde::{Deserialize, Serialize};
use diesel::prelude::*;
use utoipa::ToSchema;


#[derive(Queryable, Debug, Serialize, ToSchema, Deserialize)]
pub struct Login {

    #[schema(example = "Jeff")]
    pub username: String,
    #[schema(example = "Ab123!")]
    pub password: String,

}

#[derive(Queryable, Debug, Serialize, Deserialize)]
pub struct LoginResponse {

    pub username: String,

    pub password: String,

    pub verified: bool,

}