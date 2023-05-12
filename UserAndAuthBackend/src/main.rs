//noinspection RsMainFunctionNotFound

mod models;
mod controller;

use controller::{create, internal_error, not_found};

#[macro_use] extern crate rocket;
use rocket::{Build, catchers, Rocket, routes};


#[launch]
fn rocket() -> Rocket<Build> {
    rocket::build()
        .mount("/api/u&a", routes![create])
        .register("/", catchers![internal_error, not_found])
}