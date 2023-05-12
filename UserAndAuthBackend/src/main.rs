//noinspection RsMainFunctionNotFound

mod models;
mod controller;

use dotenvy::dotenv;
use controller::{create, internal_error, not_found};

#[macro_use] extern crate rocket;
use rocket::{Build, catchers, Rocket, routes};


#[launch]
fn rocket() -> Rocket<Build> {
    dotenv().ok();
    rocket::build()
        .attach(models::User::fairing())
        .mount("/api/auth", routes![create])
        .register("/", catchers![internal_error, not_found])

}