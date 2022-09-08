SET client_min_messages = error;

TRUNCATE TABLE "public"."spaces" RESTART IDENTITY CASCADE;
ALTER SEQUENCE spaces_id_seq RESTART WITH 1;

INSERT INTO "public"."spaces" ("name", "description", "price_per_night", "owner_id") VALUES
('Beautiful Seaside Cottage in Hastings', 'Located 15 minutes from the St Leonards-on-Sea seafront. A beautiful seaside residence with open-plan kitchen, oak wooden floors, and charming garden. Excellent for a relaxing seaside retreat.', 40, 3),
('Villa Adjacent to Lake in Porthcurno', 'A large veranda and decking area with two hammocks, perfect for relaxing. Open plan lounge and kitchen with fridge-freezer. Two bedrooms, two bathrooms. Parking spaces available.', 32, 1),
('3 Bedroom Flat located in Central London. ', 'Perfect location for a single night in Central London with abundant access to public transport. Situated 15 minutes from Euston Station. Superfast fibre-broadband internet. ', 150, 5),
('Gorgeous Country house for retreat in Bristol ', 'Features a large double bedroom with ensuite, with a spacious open-plan kitchen and dining area. Located 10 minutes from the central harbour. Includes quality self-serve breakfast in lovely kitchen with terrace and views. 100% cotton starched/pressed linen. Parking available. ', 65, 3),
('Fancy flat within minutes from Blackpool Pleasure Beach', 'Thinking of going to Blackpool for a seaside holiday? This is the perfect location! Situated within minutes from Blackpool Pleasure Beach, this is a cute little flat with 2 bedrooms and spacious living room, overlooking the street. Bookings welcome!', 73, 2),
('Rustic farm stay in Sennybridge, Brecon Beacons', 'Fresh air and luscious green hills. Experience all of the natural wonder of Brecon Beacons, go for a hike, and retreat back to this rustic farm house with glass ceiling, so you can see the stars!', 27, 3),
('Luxurious Penthouse Suite in Battersea', 'Sophistication, style and class. If you''re a party anywhere up to 10 and looking for a custom night in the heart of Central London, this penthouse suite is for you. Fitted with stylish furniture and contemporary art work, open-plan dining area with bar. DJ system and lights for indoor clubbing. Only for £250 a night.', 250, 5),
('Weekend getaway house in lovely countryside', 'Lovely countryside house for a peaceful, scenic weekend getaway. Large driveway with garage and large parking space. 2 bedrooms, 2 bathrooms with an open-plan kitchen area.', 48, 3),
('Apartment minutes from Manchester Arndale', 'Convenient location located within minutes from Manchester City Centre and 20 minutes from Trafford Shopping Centre and Old Trafford. Open-plan kitchen/lounge area, contemporary look, balcony overlooking bustling street. Perfect for exploring what Manchester has to offer!', 50, 3),
('Guest House in Oxfordshire', 'Located in the beautiful countryside in Oxfordshire. Spacious, tranquil and clean. Open-plan kitchen connecting with living room area, cute exterior with parking spaces at the front. Broadband internet available.', 69, 1),
('Scenic Guest suite in Kingston Vale', 'Beautiful guest suite with traditional decor and furnishings. Luscious garden and scenery, perfect for those looking for a peaceful weekend holiday.', 38, 6);
  