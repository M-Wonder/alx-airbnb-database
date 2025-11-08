# Entity-Relationship Diagram Requirements

## Project: Airbnb Database System
This document defines the entities, attributes, and relationships for the Airbnb-style database as specified. The ERD represents how users, properties, bookings, payments, reviews, and messages interact in the system.

---

## Entities and Attributes

### 1. User
- **user_id**: UUID, Primary Key, Indexed  
- **first_name**: VARCHAR, NOT NULL  
- **last_name**: VARCHAR, NOT NULL  
- **email**: VARCHAR, UNIQUE, NOT NULL  
- **password_hash**: VARCHAR, NOT NULL  
- **phone_number**: VARCHAR, NULL  
- **role**: ENUM('guest', 'host', 'admin'), NOT NULL  
- **created_at**: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP  

**Constraints:**
- Unique constraint on `email`
- Non-null constraints on required fields
- Indexed on `user_id` and `email`

---

### 2. Property
- **property_id**: UUID, Primary Key, Indexed  
- **host_id**: Foreign Key → User(user_id)  
- **name**: VARCHAR, NOT NULL  
- **description**: TEXT, NOT NULL  
- **location**: VARCHAR, NOT NULL  
- **pricepernight**: DECIMAL, NOT NULL  
- **created_at**: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP  
- **updated_at**: TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP  

**Constraints:**
- Foreign key constraint on `host_id` referencing User
- Non-null on essential attributes

---

### 3. Booking
- **booking_id**: UUID, Primary Key, Indexed  
- **property_id**: Foreign Key → Property(property_id)  
- **user_id**: Foreign Key → User(user_id)  
- **start_date**: DATE, NOT NULL  
- **end_date**: DATE, NOT NULL  
- **total_price**: DECIMAL, NOT NULL  
- **status**: ENUM('pending', 'confirmed', 'canceled'), NOT NULL  
- **created_at**: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP  

**Constraints:**
- Foreign key constraints on `property_id` and `user_id`
- Valid status values enforced
- Indexed on `booking_id` and `property_id`

---

### 4. Payment
- **payment_id**: UUID, Primary Key, Indexed  
- **booking_id**: Foreign Key → Booking(booking_id)  
- **amount**: DECIMAL, NOT NULL  
- **payment_date**: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP  
- **payment_method**: ENUM('credit_card', 'paypal', 'stripe'), NOT NULL  

**Constraints:**
- Foreign key constraint ensures linkage to valid bookings
- Non-null on required attributes
- Indexed on `booking_id`

---

### 5. Review
- **review_id**: UUID, Primary Key, Indexed  
- **property_id**: Foreign Key → Property(property_id)  
- **user_id**: Foreign Key → User(user_id)  
- **rating**: INTEGER, CHECK (rating >= 1 AND rating <= 5), NOT NULL  
- **comment**: TEXT, NOT NULL  
- **created_at**: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP  

**Constraints:**
- Enforce valid rating values (1–5)
- Foreign key constraints on `property_id` and `user_id`

---

### 6. Message
- **message_id**: UUID, Primary Key, Indexed  
- **sender_id**: Foreign Key → User(user_id)  
- **recipient_id**: Foreign Key → User(user_id)  
- **message_body**: TEXT, NOT NULL  
- **sent_at**: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP  

**Constraints:**
- Foreign key constraints on `sender_id` and `recipient_id`
- Non-null message content

---

## Relationships (ERD Connections)

| Relationship | Type | Description |
|---------------|------|-------------|
| **User → Property** | 1 : N | A host (User) can create multiple properties |
| **User → Booking** | 1 : N | A guest (User) can make many bookings |
| **Property → Booking** | 1 : N | A property can have multiple bookings |
| **Booking → Payment** | 1 : 1 | Each booking has one corresponding payment |
| **Property → Review** | 1 : N | Each property can have multiple reviews |
| **User → Review** | 1 : N | Each user can write multiple reviews |
| **User → Message (as Sender)** | 1 : N | A user can send multiple messages |
| **User → Message (as Recipient)** | 1 : N | A user can receive multiple messages |

---

## Indexing Summary
- **Primary keys**: Automatically indexed
- **Additional indexes**:
  - `User.email`
  - `Property.property_id`
  - `Booking.booking_id`
  - `Payment.booking_id`

---

## ER Diagram Summary
The ER diagram visually represents:
- Six main entities: **User, Property, Booking, Payment, Review, Message**
- All foreign key relationships
- Clear one-to-one and one-to-many cardinalities

**Tool Used:** [Draw.io](https://app.diagrams.net/)  
**Format:** `.drawio` and exported `.png` (optional)

---

## Author Information
**Author:** *[MAYABI WONDER]*  
**Repository:** `alx-airbnb-database`  
**Directory:** `ERD/`  
**File:** `requirements.md`
