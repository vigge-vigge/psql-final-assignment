-- SELECT b.booking_id, d.destination_address, f.airline, a.accomodation_name, b.total_price
-- FROM bookings b
-- JOIN flights f ON b.flight_id = f.flight_id
-- JOIN accomodations a ON b.accomodation_id = a.accomodation_id
-- JOIN destinations d ON f.destination_id = d.destination_id
-- WHERE b.customer_id = 5;

-- SELECT SUM(total_price) AS total_revenue
-- FROM bookings;

-- SELECT d.destination_address, COUNT(b.booking_id) AS bookings_count
-- FROM bookings b
-- JOIN flights f ON b.flight_id = f.flight_id
-- JOIN destinations d ON f.destination_id = d.destination_id
-- GROUP BY d.destination_address
-- ORDER BY bookings_count DESC
-- LIMIT 6;

-- SELECT feedback.rating, comments -- feedback.rating
-- FROM feedback
-- WHERE booking_id = 8;


-- CREATE VIEW CustomerBookings AS
-- SELECT c.customer_name, c.customer_surname, b.booking_id, d.destination_address, b.total_price
-- FROM customers c
-- JOIN bookings b ON c.customer_id = b.customer_id
-- JOIN destinations d ON d.destination_id = d.destination_id; 

-- -- JOIN flights f ON b.flight_id = f.flight_id
-- -- JOIN destinations d ON f.destination_id = d.destination_id;


-- CREATE VIEW LoyaltyMembers AS
-- SELECT c.customer_name, c.customer_surname, lp.points_earned, lp.points_redeemed 
-- FROM customers c
-- JOIN roles r ON c.role_id = r.role_id
-- JOIN customerLoyalty lp ON c.customer_id = lp.customer_id;


-- SELECT f.flight_id, f.airline, d.destination_address, f.departure_time, f.arrival_time 
-- FROM flights f
-- JOIN destinations d ON f.destination_id = d.destination_id;


-- SELECT b.booking_id, c.customer_name, c.customer_surname, b.total_price, b.booking_date
-- FROM bookings b
-- JOIN customers c ON b.customer_id = c.customer_id;

-- SELECT b.booking_id, f.airline, a.accomodation_name, b.total_price
-- FROM bookings b
-- INNER JOIN flights f ON b.flight_id = f.flight_id
-- INNER JOIN accomodations a ON b.accomodation_id = a.accomodation_id;

-- SELECT c.customer_id, c.customer_name, c.customer_surname, b.booking_id
-- FROM customers c
-- LEFT JOIN bookings b ON c.customer_id = b.customer_id;

-- SELECT f.flight_id, f.airline, b.booking_id
-- FROM flights f
-- RIGHT JOIN bookings b ON f.flight_id = b.flight_id;

-- SELECT a.accomodation_name, b.booking_id
-- FROM accomodations a
-- FULL OUTER JOIN bookings b ON a.accomodation_id = b.accomodation_id;

-- SELECT booking_id, total_price,
--     CASE
--         WHEN total_price < 1000 THEN 'Budget'
--         WHEN total_price BETWEEN 1000 AND 3000 THEN 'Standard'
--         ELSE 'Luxury'
--     END AS booking_category
-- FROM bookings;

-- SELECT feedback_id, rating,
--     CASE
--         WHEN rating = 5 THEN 'Excellent'
--         WHEN rating = 4 THEN 'Good'
--         WHEN rating = 3 THEN'Average'
--         ELSE 'Poor'
--     END AS rating_category
-- FROM feedback;

-- SELECT
--     MIN(price) AS cheapest_flight,
--     MAX(price) AS most_expensive_flight,
--     AVG(price) AS average_flight_price
-- FROM flights;

-- SELECT SUM(total_price) AS total_revenue
-- FROM bookings;

-- SELECT AVG(rating) AS average_rating
-- FROM feedback;

-- BEGIN;
-- INSERT INTO bookings(customer_id, flight_id, accomodation_id, total_price)
-- VALUES (5, 1, 1, 700.00);

-- INSERT INTO payments (booking_id, payment_method, amount)
-- VALUES (currval('bookings_booking_id_seq'), 'Credit Card', 700.00);
-- COMMIT;

-- BEGIN;
-- INSERT INTO bookings (customer_id, flight_id, accomodation_id, total_price)
-- VALUES (6, 2, 2, 1500.00);

-- ROLLBACK;

-- INSERT INTO roles (role_name) VALUES ('PremiumCustomer');

-- UPDATE customers
-- SET role_id = (SELECT role_id FROM roles WHERE role_name = 'PremiumCustomer')
-- WHERE customer_id = 5;

-- SELECT c.customer_id, c.customer_name, c.customer_surname, r.role_name
-- FROM customers c
-- JOIN roles r ON c.role_id = r.role_id
-- WHERE c.customer_id = 5;

-- SELECT d.destination_address, COUNT(b.booking_id) AS bookings_count
-- FROM bookings b
-- JOIN flights f ON b.flight_id = f.flight_id
-- JOIN destinations d ON f.destination_id = d.destination_id
-- GROUP BY d.destination_address
-- ORDER BY bookings_count DESC
-- LIMIT 1;


-- Retrieve the bookings details for a specific customer (customer_id = 5)
SELECT b.booking_id, d.destination_address, f.airline, a.accomodation_name, b.total_price
FROM bookings b
JOIN flights f ON b.flight_id = f.flight_id  -- Joining the 'flights' table on 'flight_id' to retrieve flight details like the airline.
JOIN accomodations a ON b.accomodation_id = a.accomodation_id  -- Joining the 'accomodations' table on 'accomodation_id' to get the name of the accommodation.
JOIN destinations d ON f.destination_id = d.destination_id  -- Joining the 'destinations' table on 'destination_id' (from the 'flights' table) to retrieve the destination address.
WHERE b.customer_id = 5;  -- Filtering the records to show bookings for the customer with 'customer_id' = 5.

-- Calculate the total revenue generated from all bookings by summing up the 'total_price' column in the 'bookings' table.
SELECT SUM(total_price) AS total_revenue
FROM bookings;

-- Get the top 6 destinations with the most bookings, ordered in descending order by the number of bookings.
SELECT d.destination_address, COUNT(b.booking_id) AS bookings_count
FROM bookings b
JOIN flights f ON b.flight_id = f.flight_id  -- Joining 'bookings' with 'flights' to link each booking to its respective flight.
JOIN destinations d ON f.destination_id = d.destination_id  -- Joining 'flights' with 'destinations' to get the address of each destination.
GROUP BY d.destination_address  -- Grouping the result by destination address to count how many bookings were made to each destination.
ORDER BY bookings_count DESC  -- Ordering the destinations by the number of bookings in descending order.
LIMIT 6;  -- Limiting the results to show the top 6 destinations.

-- Retrieve feedback (rating and comments) for a specific booking (booking_id = 8).
SELECT feedback.rating, comments -- Selecting 'rating' and 'comments' from the 'feedback' table.
FROM feedback
WHERE booking_id = 8;  -- Filtering the records to show the feedback for the booking with 'booking_id' = 8.

-- Create a view named 'CustomerBookings' that combines customer details with their booking and destination information.
CREATE VIEW CustomerBookings AS
SELECT c.customer_name, c.customer_surname, b.booking_id, d.destination_address, b.total_price
FROM customers c
JOIN bookings b ON c.customer_id = b.customer_id  -- Joining 'customers' table with 'bookings' to retrieve customer details associated with their bookings.
JOIN destinations d ON d.destination_id = d.destination_id;  -- Joining 'destinations' table to include the address of the destination for each booking.

-- Create a view named 'LoyaltyMembers' that combines customer loyalty information, showing earned and redeemed points for each customer.
CREATE VIEW LoyaltyMembers AS
SELECT c.customer_name, c.customer_surname, lp.points_earned, lp.points_redeemed 
FROM customers c
JOIN roles r ON c.role_id = r.role_id  -- Joining 'customers' with 'roles' to get the role of each customer (not directly used here but relevant for potential extensions).
JOIN customerLoyalty lp ON c.customer_id = lp.customer_id;  -- Joining 'customerLoyalty' table to get loyalty points data associated with each customer.

-- Retrieve flight details along with the destination addresses for each flight.
SELECT f.flight_id, f.airline, d.destination_address, f.departure_time, f.arrival_time 
FROM flights f
JOIN destinations d ON f.destination_id = d.destination_id;  -- Joining 'flights' with 'destinations' to include the destination address for each flight.

-- Retrieve customer booking details including their name, surname, booking ID, total price, and booking date.
SELECT b.booking_id, c.customer_name, c.customer_surname, b.total_price, b.booking_date
FROM bookings b
JOIN customers c ON b.customer_id = c.customer_id;  -- Joining 'bookings' with 'customers' to retrieve the customer details associated with each booking.

-- Retrieve booking details along with flight and accommodation details.
SELECT b.booking_id, f.airline, a.accomodation_name, b.total_price
FROM bookings b
INNER JOIN flights f ON b.flight_id = f.flight_id  -- Using INNER JOIN to link the 'bookings' table with the 'flights' table (only matching records).
INNER JOIN accomodations a ON b.accomodation_id = a.accomodation_id;  -- Using INNER JOIN to link 'bookings' with 'accomodations' (only matching records).

-- List all customers, including those who have no bookings (left join ensures all customers are included even if they haven't booked anything).
SELECT c.customer_id, c.customer_name, c.customer_surname, b.booking_id
FROM customers c
LEFT JOIN bookings b ON c.customer_id = b.customer_id;  -- Using LEFT JOIN ensures that customers without bookings will still appear, showing NULL for booking_id.

-- List all bookings along with their flight details (right join ensures all bookings are included, even those with no corresponding flight).
SELECT f.flight_id, f.airline, b.booking_id
FROM flights f
RIGHT JOIN bookings b ON f.flight_id = b.flight_id;  -- RIGHT JOIN ensures that even bookings without a corresponding flight will be shown, with NULL for flight details.

-- List all accommodations along with the booking details (full outer join includes records from both 'accomodations' and 'bookings' tables, even if they don't match).
SELECT a.accomodation_name, b.booking_id
FROM accomodations a
FULL OUTER JOIN bookings b ON a.accomodation_id = b.accomodation_id;  -- FULL OUTER JOIN ensures that all records from both tables will appear, even if they don't match.

-- Categorize each booking based on the 'total_price' into three categories: Budget, Standard, and Luxury.
SELECT booking_id, total_price,
    CASE
        WHEN total_price < 1000 THEN 'Budget'  -- If total_price is less than 1000, the booking is categorized as 'Budget'.
        WHEN total_price BETWEEN 1000 AND 3000 THEN 'Standard'  -- If total_price is between 1000 and 3000, it's categorized as 'Standard'.
        ELSE 'Luxury'  -- If total_price is above 3000, the booking is categorized as 'Luxury'.
    END AS booking_category
FROM bookings;

-- Categorize feedback ratings into qualitative labels (Excellent, Good, Average, Poor).
SELECT feedback_id, rating,
    CASE
        WHEN rating = 5 THEN 'Excellent'  -- If the rating is 5, it is categorized as 'Excellent'.
        WHEN rating = 4 THEN 'Good'  -- If the rating is 4, it is categorized as 'Good'.
        WHEN rating = 3 THEN 'Average'  -- If the rating is 3, it is categorized as 'Average'.
        ELSE 'Poor'  -- If the rating is less than 3, it is categorized as 'Poor'.
    END AS rating_category
FROM feedback;

-- Retrieve the cheapest, most expensive, and average price of all flights.
SELECT
    MIN(price) AS cheapest_flight,  -- 'MIN' retrieves the lowest flight price (cheapest).
    MAX(price) AS most_expensive_flight,  -- 'MAX' retrieves the highest flight price (most expensive).
    AVG(price) AS average_flight_price  -- 'AVG' calculates the average price of flights.
FROM flights;

-- Calculate the total revenue generated by summing all the booking prices.
SELECT SUM(total_price) AS total_revenue
FROM bookings;

-- Calculate the average rating from all feedback records.
SELECT AVG(rating) AS average_rating
FROM feedback;

-- Start a transaction for inserting a new booking and its payment details, ensuring the database maintains consistency.
BEGIN;
INSERT INTO bookings(customer_id, flight_id, accomodation_id, total_price)
VALUES (5, 1, 1, 700.00);  -- Insert a new booking for customer 5, specifying the flight_id, accomodation_id, and total price.

-- Insert the payment details for the new booking.
INSERT INTO payments (booking_id, payment_method, amount)
VALUES (currval('bookings_booking_id_seq'), 'Credit Card', 700.00);  -- Insert payment details using the 'currval' function to reference the last inserted booking_id.
COMMIT;  -- Commit the transaction to make the changes permanent in the database.

-- Start another transaction but roll back the changes to discard them (simulate a failed transaction).
BEGIN;
INSERT INTO bookings (customer_id, flight_id, accomodation_id, total_price)
VALUES (6, 2, 2, 1500.00);  -- Attempt to insert a new booking for customer 6.
ROLLBACK;  -- Roll back the transaction, undoing the changes made, so no new booking is created.

-- Insert a new role 'PremiumCustomer' into the 'roles' table.
INSERT INTO roles (role_name) VALUES ('PremiumCustomer');

-- Update customer 5's role to 'PremiumCustomer' by setting their 'role_id' to the 'role_id' of the 'PremiumCustomer' role.
UPDATE customers
SET role_id = (SELECT role_id FROM roles WHERE role_name = 'PremiumCustomer')  -- Subquery to find the 'role_id' for 'PremiumCustomer'.
WHERE customer_id = 5;  -- Apply the update to the customer with 'customer_id' = 5.

-- Retrieve customer details along with their assigned role name.
SELECT c.customer_id, c.customer_name, c.customer_surname, r.role_name
FROM customers c
JOIN roles r ON c.role_id = r.role_id  -- Joining 'customers' with 'roles' to get the name of the customer's role.
WHERE c.customer_id = 5;  -- Filtering for customer with 'customer_id' = 5.

-- Retrieve the destination with the highest number of bookings.
SELECT d.destination_address, COUNT(b.booking_id) AS bookings_count
FROM bookings b
JOIN flights f ON b.flight_id = f.flight_id  -- Joining 'bookings' with 'flights' to get flight details.
JOIN destinations d ON f.destination_id = d.destination_id  -- Joining 'flights' with 'destinations' to get the address of the destination.
GROUP BY d.destination_address  -- Grouping the results by destination address to count how many bookings were made for each destination.
ORDER BY bookings_count DESC  -- Sorting the results by the number of bookings in descending order.
LIMIT 1;  -- Limiting the results to show only the destination with the highest number of bookings.
