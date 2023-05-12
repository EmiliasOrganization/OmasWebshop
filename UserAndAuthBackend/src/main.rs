//noinspection RsMainFunctionNotFound

#[macro_use] extern crate rocket;
use rocket::{Build, Rocket, Request};

#[catch(500)]
fn internal_error() -> &'static str {
    "Whoops! Looks like we messed up."
}

#[catch(404)]
fn not_found(req: &Request) -> String {
    format!("I couldn't find '{}'. Try something else?", req.uri())
}

#[get("/world")]
fn hi() -> &'static str {
    "Hello!"
}

#[get("/hello")]
fn ho() -> &'static str {
    "world!"
}

#[launch]
fn rocket() -> Rocket<Build> {
    rocket::build()
        .mount("/", routes![hi, ho])
        .register("/", catchers![internal_error, not_found])
}
