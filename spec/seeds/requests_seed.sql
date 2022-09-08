SET client_min_messages = error;

TRUNCATE TABLE "public"."requests" RESTART IDENTITY CASCADE;
ALTER SEQUENCE requests_id_seq RESTART WITH 1;

INSERT INTO "public"."requests" ("space_id", "owner_id", "booker_id", "booked", "date_from", "date_to") VALUES
(2, 1, 4, 'false', '2022-09-01', '2022-11-01'),
(8, 3, 2, 'false', '2022-10-01', '2022-10-02'),
(4, 3, 1, 'false', '2022-09-01', '2022-09-09'),
(3, 5, 6, 'false', '2022-09-08', '2022-11-01'),
(1, 3, 5, 'false', '2022-12-01', '2022-12-05'),
(11, 6, 4, 'false', '2022-12-24', '2022-12-26'),
(9, 3, 4, 'false', '2022-12-27', '2022-12-30');
