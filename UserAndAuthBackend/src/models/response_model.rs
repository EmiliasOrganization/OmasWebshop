use rocket::http::{ContentType, Header,  Status};
use rocket::response::Responder;
use rocket::serde::json::Json;
use serde_json::{Value};

pub struct DefaultResponse {
    pub status: Status,
    pub content_type: ContentType,
    pub value: Value,
}

impl<'r> Responder<'r, 'static> for DefaultResponse {
    fn respond_to(self, req: &'r rocket::Request<'_>) -> rocket::response::Result<'static> {
        let json_response = Json(self.value);
        json_response.respond_to(req)
    }
}

pub struct ResponseWithHeader {
    pub status: Status,
    pub headers: Vec<(String, String)>,
    pub content_type: ContentType,
    pub value: Value,
}

impl<'r> Responder<'r, 'static> for ResponseWithHeader {
    fn respond_to(self, req: &'r rocket::Request<'_>) -> rocket::response::Result<'static> {
        let json_response = Json(self.value);
        let mut rocket_response = json_response.respond_to(req)?;

        for header in self.headers {
            let name = header.0.to_string();
            let value = header.1.to_string();
            let custom_header = Header::new(name, value);
            rocket_response.set_header(custom_header);
        }

        Ok(rocket_response)
    }
}


