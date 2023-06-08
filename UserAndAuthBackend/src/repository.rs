use diesel::{OptionalExtension, QueryDsl, QueryResult, RunQueryDsl, update};
use uuid::Uuid;
use crate::db::establish_connection_postgres;
use crate::models::{AddressTable, Login, UserTable};
use crate::diesel::ExpressionMethods;

pub fn create_user(user: UserTable) -> QueryResult<Uuid>
{
    use crate::schema::users::dsl::*;

    let connection = &mut establish_connection_postgres();

    return  diesel::insert_into(users)
        .values(&user)
        .returning(id)
        .get_result::<Uuid>(connection);
}

pub fn update_verification_status(find_username: String)
{
    use crate::schema::users::dsl::*;

    let connection = &mut establish_connection_postgres();

    update(users.filter(username.eq(find_username)))
        .set(verified.eq(true))
        .execute(connection)
        .expect("Couldnt update user verification status");
}

pub fn create_address(address: AddressTable)
{
    use crate::schema::addresses::dsl::*;

    let connection = &mut establish_connection_postgres();

    diesel::insert_into(addresses)
        .values(address)
        .execute(connection)
        .expect("Something went wrong");
}

pub fn find_hashed_password(find_username: &String) -> Option<Login>
{
    use crate::schema::users::dsl::*;

    let connection = &mut establish_connection_postgres();

    let credentials: Option<Login> = users
    .filter(username.eq(find_username))
    .select((username, password))
    .first::<(String, String)>(connection)
    .optional()
    .map(|result| {
        match result {
            Some((query_username, query_password)) => Some(Login { username:query_username, password:query_password }),
            None => None,
        }
    })
    .unwrap_or(None);

    return credentials;
}

