CREATE DATABASE easytravel;
\c easytravel

CREATE TABLE roles(
    role_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE customers(
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role_id INT REFERENCES roles(role_id) ON DELETE CASCADE,
    loyalty_points INT DEFAULT 0
);

CREATE TABLE loyaltyprogram(
    loyalty_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id) ON DELETE CASCADE,
    points_earned INT DEFAULT 0,
    points_redeemed INT DEFAULT 0
);

CREATE TABLE destinations(
    destination_id SERIAL PRIMARY KEY,
    destination_name VARCHAR (100) NOT NULL,
    region VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL
);

CREATE TABLE flights(
    flight_id SERIAL PRIMARY KEY,
    airline VARCHAR(100) NOT NULL,
    departure_time TIMESTAMP NOT NULL,
    arrival_time TIMESTAMP NOT NULL,
    origin VARCHAR(100) NOT NULL,
    destination_id INT REFERENCES destinations(destination_id) ON DELETE CASCADE,
    seat_class VARCHAR(50) NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    capacity INT NOT NULL
);

CREATE TABLE accomodations(
    accomodation_id SERIAL PRIMARY KEY,
    accomodation_name VARCHAR(100) NOT NULL,
    destination_id INT REFERENCES destinations(destination_id) ON DELETE CASCADE,
    room_type VARCHAR(50) NOT NULL,
    price_per_night NUMERIC(10, 2) NOT NULL,
    amenities TEXT
);

CREATE TABLE taxitransfers(
    transfer_id SERIAL PRIMARY KEY,
    destination_id INT REFERENCES destinations(destination_id) ON DELETE CASCADE,
    transfer_type VARCHAR(50) NOT NULL,
    special_requests TEXT
);

CREATE TABLE services(
    service_id SERIAL PRIMARY KEY,
    service_name VARCHAR(100) NOT NULL,
    price NUMERIC(10, 2) NOT NULL
):

CREATE TABLE bookings(
    booking_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id) ON DELETE CASCADE,
    flight_id INT REFERENCES flights(flight_id) ON DELETE SET NULL,
    accomodation_id INT REFERENCES accomodations(accomodation_id) ON DELETE SET NULL,
    transfer_id INT REFERENCES taxitransfers(transfer_id) ON DELETE SET NULL,
    total_price NUMERIC(10, 2) NOT NULL,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) DEFAULT 'pending'
);

CREATE TABLE bookingservices(
    booking_id INT REFERENCES bookings(booking_id) ON DELETE CASCADE,
    service_id INT REFERENCES services(service_id) ON DELETE CASCADE,
    PRIMARY KEY (booking_id, service_id)
);

CREATE TABLE payments(
    payment_id SERIAL PRIMARY KEY,
    booking_id INT REFERENCES bookings(booking_id) ON DELETE CASCADE,
    payment_method VARCHAR(50) NOT NULL,
    amount NUMERIC(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE feedback(
    feedback_id SERIAL PRIMARY KEY,
    booking_id INT REFERENCES bookings(booking_id) ON DELETE CASCADE,
    rating INT CHECK (rating BETWEEN 1AND 5),
    comments TEXT
);

CREATE TABLE promotions(
    promotion_id SERIAL PRIMARY KEY,
    promotion_name VARCHAR(100) NOT NULL,
    discount_percentage NUMERIC(5, 2) NOT NULL,
    start_date DATE NOT NULL,
    is_loyalty_exclusive BOOLEAN DEFAULT FALSE
);

CREATE TABLE bookingpromotions(
    booking_id INT REFERENCES bookings(booking_id) ON DELETE CASCADE,
    promotion_id INT REFERENCES promotions(promotion_id) ON DELETE CASCADE,
    PRIMARY KEY (booking_id, promotion_id)
);

INSERT INTO roles (role_name) VALUES ('Customer'), ('TravelAgent'), ('Admin');

INSERT INTO customers (first_name, last_name, email, password_hash, role_id)
VALUES
('Tina', 'Kales', 'tkales@gmail.com', 'klklkl',),
('Stiles', 'McCall', 'smccall23@gmail.com', 's67th', 1),
('Zeke', 'Argent', 'zargent89@gmail.com', 'zeke123', 1),
('Mia', 'Moline', 'mmoleme@gmail.com', '3386', 1)

INSERT INTO destinations (destination_name, region, country)
VALUES
('Paris', 'Ile-de-France', 'France'),
('Oryol', 'Moscow', 'Russia'),
('Rome', 'Milan', 'Italy'),
('Victoria falls', 'sub-saharan', 'Zimbabwe');

INSERT INTO flights (airline, departure_time, arrival_time, origin, destination_id, seat_class, price, capacity)
VALUES
('AirFrance', '2024-09-24 11:00:00', '2024-09-25 16:00:00', 'Paris', 1, 'Economy', 500.00, 200),
('Qatar Airways', '2024-06-05 12:20:00', '2024-06-06 17:00:00', 'Dubai', 2, 'Business', 1800.00, 20),
('Garuda Indonesia', '2024-12-05 08:00:00', '2024-12-06 12:00:00', 'Sydney', 2, 'Business', 1200.00, 50),
('AirFrance', '2024-08-15 10:00:00', '2024-08-16 14:00:00', 'New York', 1, 'Economy', 500.00, 200);

INSERT INTO accomodations (accomodation_name, destination_id, room_type, price_per_night, amenities)
VALUES
('Beacons Hotel', 1, 'Private Suite', 400.00, 'WiFi, Pool, Gym, room service'),
('Hotel Paris', 2, 'Deluxe Room', 200.00, 'WiFi, Pool, Gym'),
('Mystic Villa', 3, 'Private Villa', 700.00, 'Beach Access, Private Pool, Rental Car'), --rentl in tatenda's
('Villa Bali', 4, 'Private Villa', 300.00, 'Private Pool, Beach Access');

INSERT INTO services (service_name, price)
VALUES
('Extra Baggage', 50.00),
('Guided Tour', 100.00),
('Car Rental', 75.00);

INSERT INTO bookings (customer_id, flight_id, accomodation_id, total_price)
VALUES
(1, 1, 1, 700.00),
(2, 2, 2, 500.00),
(3, 3, 3, 1800.00),
(4, 4, 4, 1300.00),

INSERT INTO bookingservices (booking_id, service_id)
VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO payments (booking_id, payment_method, amount)
VALUES
(1, 'Credit Card', 700.00),
(2, 'Bank Transfer', 500.00),
(3, 'Bank Transfer', 1800.00),
(4, 'Credit Card', 1300.00);

INSERT INTO feedback (booking_id, rating, comments)
VALUES
(1, 5, 'Excellent Service!'),
(2, 4, 'Great experience, but the flight was delayed.'),
(3, 1, 'Poor service!'),
(4, 5, 'Amazing service, I got assisted with everything in a very professional way.');