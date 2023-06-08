#![feature(unwrap_infallible)]

extern crate diesel;
extern crate dotenv;

mod db;
mod models;
mod controller;
mod schema;
mod util;
mod repository;
mod service;
mod email;
mod handlebars_template_creator;

use controller::{
    verify,
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
use crate::controller::__path_verify;
use crate::models::Login;
use crate::models::User;
use crate::models::Address;

#[launch]
fn rocket() -> Rocket<Build> {


    #[derive(OpenApi)]
    #[openapi(
        info(
            version = "0.0.2",
            description = "Api for creating Users and authenticate them",
        ),
        paths(
            login,
            register,
        ),
        components(
            schemas(Login, User, Address),
        ),
        tags(
            (name = "Authentication", description = "Endpoints for User Authentication"),
            (name = "User Operations", description = "Endpoints for User Operations"),
        ),
    )]
    struct ApiDoc;

    rocket::build()
        .mount("/api/auth", routes![register, login, verify])
        .register("/", catchers![internal_error, not_found, conflict, missing_entity])
        .register("/api/auth/login", catchers![user_not_found])
        .mount("/", SwaggerUi::new("/swagger-ui/<_..>").url("/api-docs/openapi.json", ApiDoc::openapi()))
}

