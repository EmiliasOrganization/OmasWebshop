use bcrypt;

pub fn hash_password(password: &str) -> Result<String,bcrypt::BcryptError> {
    let salt = bcrypt::DEFAULT_COST;

    bcrypt::hash(password, salt)
}

pub fn verify_password(password: &str, hash: &str) -> bool {
    bcrypt::verify(password, hash).unwrap_or(false)
}

