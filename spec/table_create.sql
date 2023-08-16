-- Create users table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(100),
    email VARCHAR(100),
    password VARCHAR(100)
);
-- Create listings table
CREATE TABLE listings (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) on delete CASCADE,
    name VARCHAR(100),
    description TEXT,
    price_per_night NUMERIC(6,2),
    date_from DATE,
    date_to DATE
);
-- Create availability table
CREATE TABLE availability (
    id SERIAL PRIMARY KEY,
    listing_id INTEGER REFERENCES listings(id) on delete CASCADE,
    date DATE,
    available BOOLEAN DEFAULT true
);
-- Create requests table
CREATE TABLE requests (
    id SERIAL PRIMARY KEY,
    from_user_id INTEGER REFERENCES users(id),
    to_user_id INTEGER REFERENCES users(id),
    listing_id INTEGER REFERENCES listings(id),
    date DATE,
    confirmed_status BOOLEAN DEFAULT NULL,
    availability_id INTEGER REFERENCES availability(id)
);