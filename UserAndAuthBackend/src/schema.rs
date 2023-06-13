// @generated automatically by Diesel CLI.

diesel::table! {
    addresses (id) {
        id -> Uuid,
        user_id -> Uuid,
        street -> Varchar,
        city -> Varchar,
        state -> Varchar,
        zip -> Varchar,
        country -> Varchar,
        created_at -> Timestamp,
        updated_at -> Timestamp,
    }
}

diesel::table! {
    registrationcodes (code) {
        code -> Varchar,
        created_at -> Timestamp,
    }
}

diesel::table! {
    users (id) {
        id -> Uuid,
        username -> Varchar,
        lastname -> Varchar,
        firstname -> Varchar,
        email -> Varchar,
        password -> Varchar,
        verified -> Bool,
    }
}

diesel::joinable!(addresses -> users (user_id));

diesel::allow_tables_to_appear_in_same_query!(
    addresses,
    registrationcodes,
    users,
);
