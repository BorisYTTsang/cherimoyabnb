SET client_min_messages = error;

TRUNCATE TABLE "public"."users" RESTART IDENTITY CASCADE;
ALTER SEQUENCE users_id_seq RESTART WITH 1;

INSERT INTO "public"."users" ("name", "email", "password") VALUES
('Joe', 'joe@example.com', 'password123'),
('Sarah', 'saarah777@example.com', 'pass90@!'),
('Dave', 'y957yeet@example.com', 'lemonz£!@'),
('Minho', 'massivelykinjang@example.com', 'd@d@!123'),
('Gurpreet', 'gurpreet.singh@example.com', 'chrysanthemum1'),
('Cyr', 'Kyriakos.legend765@example.com', '@reyoucyrious$$');
