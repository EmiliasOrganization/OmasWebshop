
extern crate diesel;
extern crate dotenv;

mod db;
mod models;
mod controller;
mod schema;
mod util;
mod repository;
mod service;

use controller::{register,
                    login,
                 internal_error,
                 not_found,
                 conflict,
                 missing_entity};

#[macro_use] extern crate rocket;
use rocket::{Build, catchers, Rocket, routes};

#[launch]
fn rocket() -> Rocket<Build> {
    rocket::build()
        .mount("/api/auth", routes![register, login])
        .register("/", catchers![internal_error, not_found, conflict, missing_entity])
}

