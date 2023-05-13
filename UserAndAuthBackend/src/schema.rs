// @generated automatically by Diesel CLI.

diesel::table! {
    users (id) {
        id -> Int4,
        username -> Varchar,
        surname -> Varchar,
        firstname -> Varchar,
        email -> Varchar,
        password -> Varchar,
    }
}
