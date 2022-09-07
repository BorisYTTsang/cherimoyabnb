-- -------------------------------------------------------------
-- TablePlus 4.8.2(436)
--
-- https://tableplus.com/sdf
--
-- Database: cherimoyabnb
-- Generation Time: 2022-09-05 16:24:28.6090
-- -------------------------------------------------------------

-- DROP TABLE IF EXISTS "public"."users";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS users_id_seq;

-- Table Definition
CREATE TABLE "public"."users" (
    "id" int4 NOT NULL DEFAULT nextval('users_id_seq'::regclass),
    "name" text,
    "email" text,
    "password" text,
    PRIMARY KEY ("id")
);

-- DROP TABLE IF EXISTS "public"."spaces";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS spaces_id_seq;

-- Table Definition
CREATE TABLE "public"."spaces" (
    "id" int4 NOT NULL DEFAULT nextval('spaces_id_seq'::regclass),
    "name" text,
    "description" text,
    "price_per_night" int4,
    "owner_id" int4,
        -- constraint fkey_user_6 
        foreign key(owner_id)
      references users(id)
      on delete cascade,
    PRIMARY KEY ("id")
);

-- DROP TABLE IF EXISTS "public"."bookings";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS bookings_id_seq;

-- Table Definition
CREATE TABLE "public"."bookings" (
    "id" int4 NOT NULL DEFAULT nextval('bookings_id_seq'::regclass),
    "space_id" int4,
    -- constraint fkey_user_1 
    foreign key(space_id)
      references spaces(id)
      on delete cascade,
    "unavailable_from" date,
    "unavailable_to" date,
    "reason" text,
    "booker_id" int4,
    -- constraint fkey_user_2 
    foreign key(booker_id)
      references users(id)
      on delete cascade,
    PRIMARY KEY ("id")
);

-- DROP TABLE IF EXISTS "public"."requests";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS requests_id_seq;

-- Table Definition
CREATE TABLE "public"."requests" (
    "id" int4 NOT NULL DEFAULT nextval('requests_id_seq'::regclass),
    "space_id" int4,
        -- constraint fkey_user_3 
        foreign key(space_id)
      references spaces(id)
      on delete cascade,
    "owner_id" int4,
        -- constraint fkey_user_4 
        foreign key(owner_id)
      references users(id)
      on delete cascade,
    "booker_id" int4,
        -- constraint fkey_user_5 
        foreign key(booker_id)
      references users(id)
      on delete cascade,
    "booked" bool,
    PRIMARY KEY ("id")
);
