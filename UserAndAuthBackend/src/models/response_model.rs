use rocket::http::{ContentType, Header,  Status};
use rocket::{Request, Response};
use rocket::response::Responder;
use serde_json::{Value};

pub struct DefaultResponse {
    pub status: Status,
    pub content_type: ContentType,
    pub value: Value,
}

impl<'r> Responder<'r, 'static> for DefaultResponse {
    fn respond_to(self, _: &Request) -> rocket::response::Result<'static> {
        let body = serde_json::to_string(&self.value).unwrap();
        let response = Response::build()
            .status(self.status)
            .header(self.content_type)
            .sized_body(body.len(), std::io::Cursor::new(body))
            .finalize();

        Ok(response)
    }
}

pub struct ResponseWithHeader {
    pub status: Status,
    pub headers: Vec<(String, String)>,
    pub content_type: ContentType,
    pub value: Value,
}

impl<'r> Responder<'r, 'static> for ResponseWithHeader {
    fn respond_to(self, _: &Request) -> rocket::response::Result<'static> {
        let body = serde_json::to_string(&self.value).unwrap();
        let mut response = Response::build()
            .status(self.status)
            .header(self.content_type)
            .sized_body(body.len(), std::io::Cursor::new(body))
            .finalize();

        for (key, value) in self.headers {
            response.set_header(Header::new(key, value));
        }

        Ok(response)
    }
}


