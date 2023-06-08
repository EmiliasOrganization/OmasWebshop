use diesel::prelude::*;
use std::env;
use std::path::PathBuf;
use redis::Commands;

//Database Connection Postgres

pub fn establish_connection_postgres() -> PgConnection {

    let mut path = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("../.env");

    dotenv::from_path(path.as_path()).expect("Failed to load .env file");

    let database_url = env::var("DATABASE_URL").expect("DATABASE_URL must be setin .env");

    PgConnection::establish(&database_url).expect(&format!("Error connecting to {}", database_url))
}

//Redis Cache

fn establish_connection_redis() -> redis::RedisResult<redis::Connection> {
    let client = redis::Client::open("redis://127.0.0.1/")?;
    let con = client.get_connection()?;

    Ok(con)
}

pub fn store_token(token: &str, ttl_seconds: usize) -> redis::RedisResult<()> {
    let mut con = establish_connection_redis()?;
    let _: () = con.set("expected_token", token)?;
    let _: () = con.expire("expected_token", ttl_seconds)?;
    Ok(())
}

pub fn validate_token(token: &str) -> redis::RedisResult<bool> {

    let mut con =establish_connection_redis()?;

    let key_exists: bool = redis::cmd("EXISTS")
        .arg(format!("expected_token:{}", token))
        .query(&mut con)?;

    Ok(key_exists)
}

