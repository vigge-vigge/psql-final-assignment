INSERT INTO roles (role_name) VALUES ('Admin'), ('Customer'), ('TravelAgent'), ('Manager');

INSERT INTO customers (customer_name, customer_surname, customer_email, password_hash, role_id)
VALUES
('Tina', 'Kales', 'tkales@gmail.com', 'klklkl', 1),
-- ('Victor', 'Vigge', 'victorvigge@gmail.com', 'vivivi', 1);
-- ('Emmanuel', 'Akande', 'eakande@gmail.com', 'eaeaea', 1);
('Stiles', 'McCall', 'smccall23@gmail.com', 's67th', 1),
('Zeke', 'Argent', 'zargent89@gmail.com', 'zeke123', 1),
('Mia', 'Moline', 'mmoleme@gmail.com', '3386', 1);

INSERT INTO destinations (destination_address, region, country)
VALUES
('Abuja', 'Aso Rock', 'Nigeria'),
('Vaggeryd', 'Jönköping', 'Sweden'),
('Malpensa', 'Milan', 'Italy'),
('Victoria falls', 'sub-saharan', 'Zimbabwe');

INSERT INTO flights (airline, departure_time, arrival_time, flight_origin, destination_id, seat_class, price, capacity)
VALUES
('AirFrance', '2024-09-26 12:00:00', '2024-09-27 17:00:00', 'Lagos', 1, 'Economy', 400.00, 250),
('Qatar Airways', '2024-06-06 12:30:00', '2024-06-07 17:20:00', 'Barcelona', 2, 'Business', 2800.00, 50),
('Garuda Indonesia', '2024-12-07 09:00:00', '2024-12-08 10:00:00', 'Bali', 2, 'Business', 2200.00, 100),
('AirFrance', '2024-08-16 10:30:00', '2024-08-17 14:30:00', 'New Jersey', 1, 'Economy', 580.00, 100);

INSERT INTO accomodations (accomodation_name, destination_id, room_type, price_per_night, amenities)
VALUES
('Vigge Hotel', 1, 'Private Suite', 400.00, 'WiFi, Pool, Gym, room service'),
('Hotel Barcelona', 2, 'Deluxe Room', 200.00, 'WiFi, Pool, Gym'),
('Mystic Coconut Suites', 3, 'Private Villa', 700.00, 'Beach Access, Private Pool, Rental Car'),
('David Villa', 4, 'Private Villa', 500.00, 'Private Pool, Beach Access, WiFi');

INSERT INTO services (service_name, price)
VALUES
('Extra Luggage', 55.00),
('Tour Guides, Rental Car', 150.00),
('Rental Car', 55.00);

INSERT INTO bookings (customer_id, flight_id, accomodation_id, total_price)
VALUES
(5, 1, 1, 600.00),
(6, 2, 2, 400.00),
(7, 3, 3, 1900.00),
(8, 4, 4, 2900.00);

INSERT INTO bookingservices (booking_id, service_id)
VALUES
(5, 1),
(6, 2),
(7, 3);

INSERT INTO payments (booking_id, payment_method, amount)
VALUES
(5, 'Bank Transfer', 600.00),
(6, 'Credit Card', 400.00),
(7, 'Bank Transfer', 1500.00),
(8, 'Bank Transfer', 1500.00);

INSERT INTO feedback (booking_id, rating, comments)
VALUES
(5, 5, 'Amazing Service!'),
(6, 4, 'Great experience, but there was flight delay.'),
(7, 1, 'Bad service!'),
(8, 5, 'Wonderful service, Assistance with everything.');

INSERT INTO agencies (agency_name, agency_email, agency_phone_no, agency_service)
VALUES
('Vigge Agency', 'viggeagency@gmail.com', '1234567', 'Booking Flights'),
('Vigge Second Agency', 'viggeagency2@gmail.com', '2345678', 'Booking Hotels'),
('Vigge Third Agency', 'viggeagency3@gmail.com', '3456789', 'Booking Hotels and Flights'),
('Vigge Fourt Agency', 'viggeagency4@gmail.com', '4567890', 'Booking Hotels and Flights');

INSERT INTO holidayType (holiday_type_name, description)
VALUES 
    ('Bahamas', 'Premium package'),
    ('Nigeria', 'Gold package'),
    ('Thailand', 'Silver package'),
    ('Spain', 'Premium package');

INSERT INTO promotions (promotion_name, discount_percentage, start_date, end_date, is_loyalty_exclusive)
VALUES 
    ('Bahamas Premium Package Promotion', 100.00, '2025-03-01', '2025-03-31', FALSE),
    ('Nigeria Gold Package Promotion', 250.00, '2025-03-01', '2025-03-31', FALSE),
    ('Thailand Silver Package Promotion', 60.00, '2025-03-01', '2025-03-31', FALSE),
    ('Spain Premium Package Promotion', 10.00, '2025-03-01', '2025-03-31', FALSE);

INSERT INTO customer_holiday_types (customer_id, holiday_type_id)
VALUES
    (6, 2),
    (6, 3),
    (7, 1),
    (7, 2),
    (8, 4),
    (5, 1),
    (5, 3);


--after skills up to select ratings
-- INSERT INTO promotions (promotion_id, promotion_name, start_date, end_date, discount)
-- VALUES (1, 'Summer Sale', '2023-06-01', 2023-08)

