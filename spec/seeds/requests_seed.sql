SET client_min_messages = error;

TRUNCATE TABLE "public"."requests" RESTART IDENTITY CASCADE;
ALTER SEQUENCE requests_id_seq RESTART WITH 1;

INSERT INTO "public"."requests" ("space_id", "owner_id", "booker_id", "booked") VALUES
(2, 1, 4, 'false'),
(8, 3, 2, 'false'),
(4, 3, 1, 'false'),
(3, 5, 6, 'false'),
(1, 3, 5, 'false'),
(11, 6, 4, 'false'),
(9, 3, 4, 'false');
