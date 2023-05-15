
extern crate diesel;
extern crate dotenv;

mod db;
mod models;
mod controller;
mod schema;
mod util;
mod repository;
mod service;

use controller::{
    register,
    login,
    internal_error,
    not_found,
    conflict,
    missing_entity,
    user_not_found,
};

#[macro_use] extern crate rocket;
use rocket::{Build, catchers, Rocket, routes};
use utoipa_swagger_ui::SwaggerUi;
use utoipa::OpenApi;
use crate::controller::__path_login;
use crate::controller::__path_register;
use crate::models::Login;
use crate::models::User;
use crate::models::Address;

#[launch]
fn rocket() -> Rocket<Build> {



    #[derive(OpenApi)]
    #[openapi(
        paths(
            login,
            register,
        ),
        components(
            schemas(Login, User, Address),
        ),
        tags(
            (name = "Login", description = "Authentication")
        ),
    )]
    struct ApiDoc;

    rocket::build()
        .mount("/api/auth", routes![register, login])
        .register("/", catchers![internal_error, not_found, conflict, missing_entity])
        .register("/api/auth/login", catchers![user_not_found])
        .mount("/", SwaggerUi::new("/swagger-ui/<_..>").url("/api-docs/openapi.json", ApiDoc::openapi()))
}

