use diesel::{QueryResult, RunQueryDsl};
use uuid::Uuid;
use crate::db::establish_connection;
use crate::models::{AddressTable, UserTable};
use crate::schema::users::table;

pub fn create_user(user: UserTable) -> QueryResult<Uuid>
{
    use crate::schema::users::dsl::*;

    let connection = &mut establish_connection();

    return  diesel::insert_into(users)
        .values(&user)
        .returning(id)
        .get_result::<Uuid>(connection);
}

pub fn create_address(address: AddressTable)
{
    use crate::schema::addresses::dsl::*;

    let connection = &mut establish_connection();

    diesel::insert_into(addresses)
        .values(address)
        .execute(connection)
        .expect("Something went wrong");
}


