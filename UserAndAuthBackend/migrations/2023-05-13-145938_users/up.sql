CREATE TABLE IF NOT EXISTS users (
   "id" UUID DEFAULT gen_random_uuid() PRIMARY KEY,
   "username" VARCHAR NOT NULL UNIQUE,
   "surname" VARCHAR NOT NULL,
   "firstname" VARCHAR NOT NULL,
   "email" VARCHAR NOT NULL UNIQUE,
   "password" VARCHAR NOT NULL,
   "verified" BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE  IF NOT EXISTS addresses (
   "id" UUID DEFAULT gen_random_uuid() PRIMARY KEY,
   "user_id" UUID NOT NULL,
   "street" VARCHAR NOT NULL,
   "city" VARCHAR NOT NULL,
   "state" VARCHAR NOT NULL,
   "zip" VARCHAR NOT NULL,
   "country" VARCHAR NOT NULL,
   "created_at" TIMESTAMP NOT NULL DEFAULT NOW(),
   "updated_at" TIMESTAMP NOT NULL DEFAULT NOW(),
   CONSTRAINT "fk_user_id" FOREIGN KEY ("user_id") REFERENCES users("id") ON DELETE CASCADE
);