
\c easytravel2

CREATE TABLE roles(
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE customers(
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    customer_surname VARCHAR(50) NOT NULL,
    customer_email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role_id INT REFERENCES roles(role_id) ON DELETE CASCADE,
    loyalty_points INT DEFAULT 0
);

CREATE TABLE customerLoyalty(
    loyalty_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id) ON DELETE CASCADE,
    points_earned INT DEFAULT 0,
    points_redeemed INT DEFAULT 0x
);

CREATE TABLE destinations(
    destination_id SERIAL PRIMARY KEY,
    destination_address VARCHAR (100) NOT NULL,
    region VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL
);

CREATE TABLE flights(
    flight_id SERIAL PRIMARY KEY,
    airline VARCHAR(100) NOT NULL,
    departure_time TIMESTAMP NOT NULL,
    arrival_time TIMESTAMP NOT NULL,
    flight_origin VARCHAR(100) NOT NULL,
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

CREATE TABLE taxiTransfers(
    transfer_id SERIAL PRIMARY KEY,
    destination_id INT REFERENCES destinations(destination_id) ON DELETE CASCADE,
    transfer_type VARCHAR(50) NOT NULL,
    special_requests TEXT
);

CREATE TABLE services(
    service_id SERIAL PRIMARY KEY,
    service_name VARCHAR(100) NOT NULL,
    price NUMERIC(10, 2) NOT NULL
); --change to semi colon

CREATE TABLE bookings(
    booking_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id) ON DELETE CASCADE,
    flight_id INT REFERENCES flights(flight_id) ON DELETE SET NULL,
    accomodation_id INT REFERENCES accomodations(accomodation_id) ON DELETE SET NULL,
    transfer_id INT REFERENCES taxitransfers(transfer_id) ON DELETE SET NULL,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_price NUMERIC(10, 2) NOT NULL,
    status VARCHAR(50) DEFAULT 'pending' -- should be enum
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
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comments TEXT
);

CREATE TABLE promotions(
    promotion_id SERIAL PRIMARY KEY,
    promotion_name VARCHAR(100) NOT NULL,
    discount_percentage NUMERIC(5, 2) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    is_loyalty_exclusive BOOLEAN DEFAULT FALSE
);

CREATE TABLE bookingpromotions(
    booking_id INT REFERENCES bookings(booking_id) ON DELETE CASCADE,
    promotion_id INT REFERENCES promotions(promotion_id) ON DELETE CASCADE,
    PRIMARY KEY (booking_id, promotion_id)
);

CREATE TABLE agencies(
    agency_id SERIAL PRIMARY KEY,
    agency_name VARCHAR(100) NOT NULL,
    agency_email VARCHAR(100) NOT NULL,
    agency_phone_no VARCHAR(15) NOT NULL,
    agency_address VARCHAR(100),
    established_date DATE,
    agency_service VARCHAR(255) NOT NULL
);

CREATE TABLE holidayType( -- holiday package for the customer. The customer can access the agency through this
    holiday_type_id SERIAL PRIMARY KEY,
    holiday_type_name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL
);

CREATE TABLE customer_holiday_types (
    customer_id INT REFERENCES customers(customer_id) ON DELETE CASCADE,
    holiday_type_id INT REFERENCES holidayType(holiday_type_id) ON DELETE CASCADE,
    PRIMARY KEY (customer_id, holiday_type_id)
);

ALTER TABLE services
ADD COLUMN agency_id INT REFERENCES agencies(agency_id) ON DELETE SET NULL;

ALTER TABLE promotions
ADD COLUMN agency_id INT REFERENCES agencies(agency_id) ON DELETE CASCADE;

ALTER TABLE agencies
ADD COLUMN holiday_type_id INT REFERENCES holidayType(holiday_type_id) ON DELETE SET NULL; -- customer can access agencies through holiday packages

ALTER TABLE agencies
    DROP COLUMN holiday_type_id;



CREATE ROLE admin_role PASSWORD 'admin123';

CREATE ROLE agency_role PASSWORD 'agency123';

CREATE ROLE customer_role PASSWORD 'customer123';

-- Admin role


GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public to admin_role;
ALTER TABLE customers OWNER TO admin_role;
ALTER TABLE customerLoyalty OWNER TO admin_role;
ALTER TABLE destinations OWNER TO admin_role;
ALTER TABLE flights OWNER TO admin_role;
ALTER TABLE accomodations OWNER TO admin_role;
ALTER TABLE taxiTransfers OWNER TO admin_role;
ALTER TABLE services OWNER TO admin_role;
ALTER TABLE bookings OWNER TO admin_role;
ALTER TABLE bookingservices OWNER TO admin_role;
ALTER TABLE payments OWNER TO admin_role;
ALTER TABLE feedback OWNER TO admin_role;
ALTER TABLE promotions OWNER TO admin_role;
ALTER TABLE bookingpromotions OWNER TO admin_role;
ALTER TABLE agencies OWNER TO admin_role;
ALTER TABLE holidayType OWNER TO admin_role;
ALTER TABLE customer_holiday_types OWNER TO admin_role;


-- Agency role. Done

GRANT SELECT ON customers TO agency_role;
GRANT SELECT ON destinations TO agency_role;
GRANT SELECT ON flights TO agency_role;
GRANT SELECT ON accomodations TO agency_role;
GRANT SELECT ON taxiTransfers TO agency_role;
GRANT SELECT ON services TO agency_role;
GRANT SELECT ON bookings TO agency_role;
GRANT SELECT ON payments TO agency_role;
GRANT SELECT ON feedback TO agency_role;
GRANT SELECT ON promotions TO agency_role;
GRANT SELECT ON agencies TO agency_role;
GRANT SELECT ON holidayType TO agency_role;

GRANT INSERT ON customers TO agency_role;
GRANT INSERT ON destinations TO agency_role;
GRANT INSERT ON flights TO agency_role;
GRANT INSERT ON accomodations TO agency_role;
GRANT INSERT ON taxiTransfers TO agency_role;
GRANT INSERT ON services TO agency_role;
GRANT INSERT ON bookings TO agency_role;
GRANT INSERT ON payments TO agency_role;
GRANT INSERT ON feedback TO agency_role;
GRANT INSERT ON promotions TO agency_role;
GRANT INSERT ON agencies TO agency_role;
GRANT INSERT ON holidayType TO agency_role;

GRANT USAGE, SELECT ON SEQUENCE customers_customer_id_seq TO agency_role;
GRANT USAGE, SELECT ON SEQUENCE customerLoyalty_loyalty_id_seq TO agency_role;
GRANT USAGE, SELECT ON SEQUENCE destinations_destination_id_seq TO agency_role;
GRANT USAGE, SELECT ON SEQUENCE flights_flight_id_seq TO agency_role;
GRANT USAGE, SELECT ON SEQUENCE accomodations_accomodation_id_seq TO agency_role;
GRANT USAGE, SELECT ON SEQUENCE taxiTransfers_transfer_id_seq TO agency_role;
GRANT USAGE, SELECT ON SEQUENCE services_service_id_seq TO agency_role;
GRANT USAGE, SELECT ON SEQUENCE bookings_booking_id_seq TO agency_role;
GRANT USAGE, SELECT ON SEQUENCE payments_payment_id_seq TO agency_role;
GRANT USAGE, SELECT ON SEQUENCE feedback_feedback_id_seq TO agency_role;
GRANT USAGE, SELECT ON SEQUENCE promotions_promotion_id_seq TO agency_role;
GRANT USAGE, SELECT ON SEQUENCE agencies_agency_id_seq TO agency_role;
GRANT USAGE, SELECT ON SEQUENCE holidayType_holiday_type_id_seq TO agency_role;

GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE customer_holiday_types TO agency_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE bookingpromotions TO agency_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE bookingservices TO agency_role;


GRANT UPDATE ON customers TO agency_role;
GRANT UPDATE ON destinations TO agency_role;
GRANT UPDATE ON flights TO agency_role;
GRANT UPDATE ON accomodations TO agency_role;
GRANT UPDATE ON taxiTransfers TO agency_role;
GRANT UPDATE ON services TO agency_role;
GRANT UPDATE ON bookings TO agency_role;
GRANT UPDATE ON payments TO agency_role;
GRANT UPDATE ON feedback TO agency_role;
GRANT UPDATE ON promotions TO agency_role;
GRANT UPDATE ON agencies TO agency_role;
GRANT UPDATE ON holidayType TO agency_role;


-- Customer role. done
ALTER ROLE customer_role WITH LOGIN;

GRANT SELECT ON customerLoyalty TO customer_role;
GRANT SELECT ON destinations TO customer_role;
GRANT SELECT ON flights TO customer_role;
GRANT SELECT ON accomodations TO customer_role;
GRANT SELECT ON taxiTransfers TO customer_role;
GRANT SELECT ON services TO customer_role;
GRANT SELECT ON bookings TO customer_role;
GRANT SELECT ON payments TO customer_role;
GRANT SELECT ON feedback TO customer_role;
GRANT SELECT ON promotions TO customer_role;
GRANT SELECT ON agencies TO customer_role;
GRANT SELECT ON holidayType TO customer_role;


-- to access on powershell
-- psql -U admin_role -d easytravel2 

ALTER TABLE customers ADD COLUMN test VARCHAR(50);
ALTER TABLE customers DROP COLUMN test;