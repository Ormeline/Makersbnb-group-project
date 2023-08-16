-- DROP TABLE IF EXISTS listings;
-- DROP TABLE IF EXISTS users;
-- DROP TABLE IF EXISTS availability;
-- DROP TABLE IF EXISTS requests;

TRUNCATE TABLE users, listings, availability, requests RESTART IDENTITY CASCADE;
-- Insert a user
INSERT INTO users (username, email, password) VALUES ('user1', 'user1@email.com', 'password1');
INSERT INTO users (username, email, password) VALUES ('user2', 'user2@email.com', 'password2');
INSERT INTO users (username, email, password) VALUES ('user3', 'user3@email.com', 'password3');
-- Insert a listing
INSERT INTO listings (user_id, name, description, price_per_night, date_from, date_to) VALUES (1, 'Lovely cottage', 'A beautiful and cozy cottage in the countryside.', 100.00, '2023-06-01', '2023-06-01');
INSERT INTO listings (user_id, name, description, price_per_night, date_from, date_to) VALUES (2, 'A Second Listing', 'Different cottage in the countryside.', 200.00, '2023-09-09', '2023-09-13');
-- Insert an availability
INSERT INTO availability (listing_id, date, available) VALUES (1, '2023-06-01', TRUE);
INSERT INTO availability (listing_id, date, available) VALUES (2, '2023-09-09', TRUE);
INSERT INTO availability (listing_id, date, available) VALUES (2, '2023-09-10', TRUE);
INSERT INTO availability (listing_id, date, available) VALUES (2, '2023-09-11', TRUE);
INSERT INTO availability (listing_id, date, available) VALUES (2, '2023-09-12', TRUE);
INSERT INTO availability (listing_id, date, available) VALUES (2, '2023-09-13', FALSE);
-- Insert a request
INSERT INTO requests (from_user_id, to_user_id, listing_id, date, availability_id) VALUES (1, 2, 1, '2023-06-01', 1);