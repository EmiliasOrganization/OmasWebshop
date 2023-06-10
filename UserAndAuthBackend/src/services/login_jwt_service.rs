use bcrypt::verify;
use rocket::http::{ContentType, Cookie, CookieJar, Status};
use rocket::serde::json::Json;
use serde_json::json;
use crate::models::login_model::Login;
use crate::models::response_model::{DefaultResponse, ResponseWithHeader};
use crate::repository::find_hashed_password;
use crate::utils::jwt_util::{generate_jwt, validate_jwt_token};

pub async fn login_user_service(user_login: Json<Login>) -> ResponseWithHeader {
    let credentials = find_hashed_password(&user_login.username);
    let mut status = Status::Unauthorized;
    let mut verified = false;
    let mut headers= vec![];

    match credentials {
        Some(login) => {
            if verify(&user_login.password, &login.password).expect("Error verifying password") {
                if login.verified {
                    let token = generate_jwt(login.username.to_owned()).expect("Cant generate JWT");

                    let cookie = Cookie::build("jwt-token", token)
                        .http_only(true)
                        .finish();

                    headers = vec![
                        ("Set-Cookie".to_string(), cookie.to_string()),
                    ];
                    verified = true;
                    status = Status::Ok;
                }
            }
        }
        None => {}

    }
    ResponseWithHeader {
        status,
        headers,
        content_type: ContentType::JSON,
        value: json!({"verified": verified})
    }
}

pub fn verify_jwt_service(cookies: &CookieJar<'_>) -> DefaultResponse {
    let token_cookie = cookies.get("jwt-token");
    let mut jwt_verified = false;
    let mut status = Status::Unauthorized;

    if let Some(cookie) = token_cookie {
        let token = cookie.value();

        if validate_jwt_token(token) {
            jwt_verified = true;
            status = Status::Ok;
        }
    }

    DefaultResponse {
        status,
        content_type: ContentType::JSON,
        value: json!({"verified": jwt_verified})
    }
}
