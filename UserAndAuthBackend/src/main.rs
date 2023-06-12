#![feature(unwrap_infallible)]

extern crate diesel;
extern crate dotenv;

mod config;
mod models {
    pub mod login_model;
    pub mod address_model;
    pub mod user_model;
    pub mod response_model;
    pub mod jwt_model;
}
mod services{
    pub mod login_jwt_service;
    pub mod registration_service;
    pub mod reset_password_service;
}
mod utils{
    pub mod email_validation_util;
    pub mod hash_password_util;
    pub mod jwt_util;
}
mod controller;
mod schema;
mod repository;
mod email;
mod handlebars_template_creator;

use controller::{
    all_options,
    verify_email,
    verify_jwt,
    register,
    login,
    internal_error,
    not_found,
    conflict,
    missing_entity,
    user_not_found,
};

#[macro_use] extern crate rocket;
use rocket::{Build, catchers, Request, Response, Rocket, routes};
use rocket::fairing::{Fairing, Info, Kind};
use rocket::http::Header;
use utoipa_swagger_ui::SwaggerUi;
use utoipa::OpenApi;
use crate::controller::__path_login;
use crate::controller::__path_register;
use crate::models::login_model::Login;
use crate::models::user_model::User;
use crate::models::address_model::Address;

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
        .mount("/api/auth", routes![all_options, register, login, verify_email, verify_jwt])
        .register("/", catchers![internal_error, not_found, conflict, missing_entity])
        .register("/api/auth/login", catchers![user_not_found])
        .mount("/", SwaggerUi::new("/swagger-ui/<_..>").url("/api-docs/openapi.json", ApiDoc::openapi()))
        .attach(CORS)
}

pub struct CORS;

#[rocket::async_trait]
impl Fairing for CORS {
    fn info(&self) -> Info {
        Info {
            name: "Add CORS headers to responses",
            kind: Kind::Response
        }
    }

    async fn on_response<'r>(&self, _request: &'r Request<'_>, response: &mut Response<'r>) {
        response.set_header(Header::new("Access-Control-Allow-Origin", "*"));
        response.set_header(Header::new("Access-Control-Allow-Methods", "POST, GET, PATCH, OPTIONS"));
        response.set_header(Header::new("Access-Control-Allow-Headers", "*"));
        response.set_header(Header::new("Access-Control-Allow-Credentials", "true"));
    }
}
