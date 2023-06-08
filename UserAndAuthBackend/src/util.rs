use std::path::PathBuf;
use bcrypt;
use rand::Rng;

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

pub fn load_env() {
    let mut path = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    path.push("../.env");

    dotenv::from_path(path.as_path()).expect("Failed to load .env file");
}



