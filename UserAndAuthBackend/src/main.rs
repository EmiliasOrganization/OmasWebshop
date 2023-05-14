
extern crate diesel;
extern crate dotenv;

mod db;
mod models;
mod controller;
mod schema;
mod util;

use controller::{register, internal_error, not_found, conflict};

#[macro_use] extern crate rocket;
use rocket::{Build, catchers, Rocket, routes};

#[launch]
fn rocket() -> Rocket<Build> {
    rocket::build()
        .mount("/api/auth", routes![register])
        .register("/", catchers![internal_error, not_found, conflict])
}

