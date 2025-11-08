-- Airbnb Database Sample Data
-- Author: [Your Name]
-- File: seed.sql

-- =======================================================
-- Make sure the schema exists before running this file.
-- Run: \i ../database-script-0x01/schema.sql
-- =======================================================

-- Enable extension for UUID generation (PostgreSQL)
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- =======================================================
-- 1. USER TABLE DATA
-- =======================================================
INSERT INTO "User" (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
    (gen_random_uuid(), 'Alice', 'Wanjiru', 'alice@example.com', 'hashed_pw_1', '+254712345678', 'host'),
    (gen_random_uuid(), 'Brian', 'Odhiambo', 'brian@example.com', 'hashed_pw_2', '+254722334455', 'guest'),
    (gen_random_uuid(), 'Cynthia', 'Kamau', 'cynthia@example.com', 'hashed_pw_3', '+254733556677', 'guest'),
    (gen_random_uuid(), 'Daniel', 'Mutua', 'daniel@example.com', 'hashed_pw_4', '+254744667788', 'host'),
    (gen_random_uuid(), 'Eunice', 'Mwikali', 'eunice@example.com', 'hashed_pw_5', '+254755889900', 'admin');

-- =======================================================
-- 2. PROPERTY TABLE DATA
-- =======================================================
-- Select host IDs dynamically
-- You can verify the IDs after inserting into User.
-- Example query: SELECT user_id, first_name FROM "User" WHERE role='host';

INSERT INTO Property (property_id, host_id, name, description, location, pricepernight)
SELECT gen_random_uuid(), user_id, name, description, location, pricepernight
FROM (
    VALUES
        ('', 'Cozy Apartment in Nairobi', 'Modern 2-bedroom apartment with Wi-Fi and parking', 'Nairobi, Kenya', 6500.00),
        ('', 'Beachfront Villa', 'Luxurious 3-bedroom villa with ocean view and pool', 'Diani Beach, Kenya', 18500.00)
) AS p(dummy, name, description, location, pricepernight)
JOIN "User" u ON u.first_name IN ('Alice', 'Daniel');

-- =======================================================
-- 3. BOOKING TABLE DATA
-- =======================================================
-- Select property and guest IDs dynamically
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status)
SELECT gen_random_uuid(), p.property_id, u.user_id, start_date, end_date, total_price, status
FROM (
    VALUES
        ('2025-11-10', '2025-11-14', 26000.00, 'confirmed'),
        ('2025-12-01', '2025-12-05', 74000.00, 'pending'),
        ('2025-12-10', '2025-12-15', 92500.00, 'confirmed')
) AS b(start_date, end_date, total_price, status)
JOIN Property p ON TRUE
JOIN "User" u ON u.role = 'guest'
LIMIT 3;

-- =======================================================
-- 4. PAYMENT TABLE DATA
-- =======================================================
INSERT INTO Payment (payment_id, booking_id, amount, payment_method)
SELECT gen_random_uuid(), booking_id, total_price, 'credit_card'
FROM Booking
WHERE status = 'confirmed'
LIMIT 2;

-- =======================================================
-- 5. REVIEW TABLE DATA
-- =======================================================
INSERT INTO Review (review_id, property_id, user_id, rating, comment)
SELECT gen_random_uuid(), p.property_id, u.user_id, rating, comment
FROM (
    VALUES
        (5, 'Amazing stay! Very clean and peaceful.'),
        (4, 'Good experience overall, but Wi-Fi was slow.')
) AS r(rating, comment)
JOIN Property p ON TRUE
JOIN "User" u ON u.role = 'guest'
LIMIT 2;

-- =======================================================
-- 6. MESSAGE TABLE DATA
-- =======================================================
INSERT INTO Message (message_id, sender_id, recipient_id, message_body)
SELECT gen_random_uuid(), sender.user_id, recipient.user_id, msg
FROM (
    VALUES
        ('Is your apartment available next weekend?'),
        ('Yes, it’s available. Would you like to book?'),
        ('Thank you! I just made the payment.')
) AS m(msg)
JOIN "User" sender ON sender.role = 'guest'
JOIN "User" recipient ON recipient.role = 'host'
LIMIT 3;

-- =======================================================
-- END OF SEED DATA
-- =======================================================

