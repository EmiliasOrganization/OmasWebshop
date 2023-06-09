use std::env;
use chrono::{Duration, Utc};
use jsonwebtoken::{decode, DecodingKey, encode, EncodingKey, Header, Validation};
use crate::config::load_env;
use crate::models::jwt_model::Claims;

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

pub fn validate_jwt_token(token: &str) -> bool {
    let secret = env::var("JWT_SECRET").expect("JWT_SECRET must be set in .env");

    let secret_key = DecodingKey::from_secret(secret.as_ref());

    let validation = Validation::default();

    match decode::<Claims>(token, &secret_key, &validation) {
        Ok(_) => true, // Token is valid
        Err(_) => false, // Token validation failed
    }
}