SET client_min_messages = error;

TRUNCATE TABLE "public"."bookings" RESTART IDENTITY CASCADE;
ALTER SEQUENCE bookings_id_seq RESTART WITH 1;

INSERT INTO "public"."bookings" ("space_id", "unavailable_from", "unavailable_to", "reason", "booker_id") VALUES
(1, '2022-09-10', '2022-09-20', 'booking', 1),
(3, '2022-10-10', '2022-10-14', 'booking', 3),
(4, '2022-10-06', '2022-11-12', 'booking', 2),
(7, '2022-12-01', '2022-12-25', 'booking', 5),
(1, '2022-09-22', '2022-09-25', 'booking', 6);

