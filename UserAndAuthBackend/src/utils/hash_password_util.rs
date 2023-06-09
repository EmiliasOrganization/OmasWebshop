
pub fn hash_password(password: &str) -> Result<String,bcrypt::BcryptError> {
    let salt = bcrypt::DEFAULT_COST;

    bcrypt::hash(password, salt)
}