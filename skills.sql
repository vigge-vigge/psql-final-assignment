SELECT b.booking_id, d.destination_address, f.airline, a.accomodation_name, b.total_price
FROM bookings b
JOIN flights f ON b.flight_id = f.flight_id
JOIN accomodations a ON b.accomodation_id = a.accomodation_id
JOIN destinations d ON f.destination_id = d.destination_id
WHERE b.customer_id = 5;

SELECT SUM(total_price) AS total_revenue
FROM bookings;

SELECT d.destination_address, COUNT(b.booking_id) AS bookings_count
FROM bookings b
JOIN flights f ON b.flight_id = f.flight_id
JOIN destinations d ON f.destination_id = d.destination_id
GROUP BY d.destination_address
ORDER BY bookings_count DESC
LIMIT 6;

SELECT feedback.rating, comments -- feedback.rating
FROM feedback
WHERE booking_id = 8;


CREATE VIEW CustomerBookings AS
SELECT c.customer_name, c.customer_surname, b.booking_id, d.destination_address, b.total_price
FROM customers c
JOIN bookings b ON c.customer_id = b.customer_id
JOIN destinations d ON d.destination_id = d.destination_id; 

-- JOIN flights f ON b.flight_id = f.flight_id
-- JOIN destinations d ON f.destination_id = d.destination_id;


CREATE VIEW LoyaltyMembers AS
SELECT c.customer_name, c.customer_surname, lp.points_earned, lp.points_redeemed 
FROM customers c
JOIN roles r ON c.role_id = r.role_id
JOIN customerLoyalty lp ON c.customer_id = lp.customer_id;


SELECT f.flight_id, f.airline, d.destination_address, f.departure_time, f.arrival_time 
FROM flights f
JOIN destinations d ON f.destination_id = d.destination_id;


SELECT b.booking_id, c.customer_name, c.customer_surname, b.total_price, b.booking_date
FROM bookings b
JOIN customers c ON b.customer_id = c.customer_id;

SELECT b.booking_id, f.airline, a.accomodation_name, b.total_price
FROM bookings b
INNER JOIN flights f ON b.flight_id = f.flight_id
INNER JOIN accomodations a ON b.accomodation_id = a.accomodation_id;

SELECT c.customer_id, c.customer_name, c.customer_surname, b.booking_id
FROM customers c
LEFT JOIN bookings b ON c.customer_id = b.customer_id;

SELECT f.flight_id, f.airline, b.booking_id
FROM flights f
RIGHT JOIN bookings b ON f.flight_id = b.flight_id;

SELECT a.accomodation_name, b.booking_id
FROM accomodations a
FULL OUTER JOIN bookings b ON a.accomodation_id = b.accomodation_id;

SELECT booking_id, total_price,
    CASE
        WHEN total_price < 1000 THEN 'Budget'
        WHEN total_price BETWEEN 1000 AND 3000 THEN 'Standard'
        ELSE 'Luxury'
    END AS booking_category
FROM bookings;

SELECT feedback_id, rating,
    CASE
        WHEN rating = 5 THEN 'Excellent'
        WHEN rating = 4 THEN 'Good'
        WHEN rating = 3 THEN'Average'
        ELSE 'Poor'
    END AS rating_category
FROM feedback;

SELECT
    MIN(price) AS cheapest_flight,
    MAX(price) AS most_expensive_flight,
    AVG(price) AS average_flight_price
FROM flights;

SELECT SUM(total_price) AS total_revenue
FROM bookings;

SELECT AVG(rating) AS average_rating
FROM feedback;

BEGIN;
INSERT INTO bookings(customer_id, flight_id, accomodation_id, total_price)
VALUES (5, 1, 1, 700.00);

INSERT INTO payments (booking_id, payment_method, amount)
VALUES (currval('bookings_booking_id_seq'), 'Credit Card', 700.00);
COMMIT;

BEGIN;
INSERT INTO bookings (customer_id, flight_id, accomodation_id, total_price)
VALUES (6, 2, 2, 1500.00);

ROLLBACK;

INSERT INTO roles (role_name) VALUES ('PremiumCustomer');

UPDATE customers
SET role_id = (SELECT role_id FROM roles WHERE role_name = 'PremiumCustomer')
WHERE customer_id = 5;

SELECT c.customer_id, c.customer_name, c.customer_surname, r.role_name
FROM customers c
JOIN roles r ON c.role_id = r.role_id
WHERE c.customer_id = 5;

SELECT d.destination_address, COUNT(b.booking_id) AS bookings_count
FROM bookings b
JOIN flights f ON b.flight_id = f.flight_id
JOIN destinations d ON f.destination_id = d.destination_id
GROUP BY d.destination_address
ORDER BY bookings_count DESC
LIMIT 1;