use rand::Rng;
use redis::Commands;
use crate::config::establish_connection_redis;

pub fn generate_email_token() -> String {
    let token: String = rand::thread_rng()
        .sample_iter(rand::distributions::Alphanumeric)
        .take(20)
        .map(char::from)
        .collect();
    token
}

pub fn store_email_token(token: &str, username: String, ttl_seconds: usize) -> redis::RedisResult<()> {
    let mut con = establish_connection_redis()?;
    let _: () = con.set_ex(token,  username, ttl_seconds)?;

    Ok(())
}

pub fn validate_email_token(token: &str) -> redis::RedisResult<bool> {
    let mut con = establish_connection_redis()?;
    let key_exists: bool = con.exists(token)?;

    Ok(key_exists)
}

pub fn get_username(token: &str) -> redis::RedisResult<Option<String>> {
    let mut con = establish_connection_redis()?;
    let username :Option<String> = con.get(token)?;

    Ok(username)
}