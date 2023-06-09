use std::env;
use std::path::PathBuf;
use bcrypt;
use chrono::{Duration, Utc};
use jsonwebtoken::{decode, DecodingKey, encode, EncodingKey, Header, Validation};
use rand::Rng;
use serde::{Deserialize, Serialize};



pub fn hash_password(password: &str) -> Result<String,bcrypt::BcryptError> {
    let salt = bcrypt::DEFAULT_COST;

    bcrypt::hash(password, salt)
}

pub fn generate_email_token() -> String {
    let token: String = rand::thread_rng()
        .sample_iter(rand::distributions::Alphanumeric)
        .take(20)
        .map(char::from)
        .collect();
    token
}

#[derive(Debug, Serialize, Deserialize)]
struct Claims {
    sub: String,
    exp: usize,
    // Add any other fields you need
}

pub fn generate_jwt(username: String) -> Result<String, jsonwebtoken::errors::Error> {

    let current_time = Utc::now();
    let expiration_time = current_time + Duration::hours(24);

    load_env();

    let secret = env::var("JWT_SECRET").expect("JWT_SECRET must be set in .env");

    let secret_key = EncodingKey::from_secret(secret.as_ref());

    let claims = Claims {
        sub: username,
        exp: expiration_time.timestamp() as usize,
    };

    let token = encode(
        &Header::default(),
        &claims,
        &secret_key,
    )?;

    Ok(token)
}

fn validate_token(token: &str) -> Result<Claims, jsonwebtoken::errors::Error> {
    let validation = Validation::default();

    let secret_key = DecodingKey::from_secret("your-secret-key".as_ref());

    let decoded = decode::<Claims>(token, &secret_key, &validation)?;

    Ok(decoded.claims)
}


pub fn load_env() {
    let mut path = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("../.env");

    dotenv::from_path(path.as_path()).expect("Failed to load .env file");
}



