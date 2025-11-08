# Airbnb Database Normalization

## Objective
To ensure that the Airbnb database design adheres to the **Third Normal Form (3NF)**, eliminating redundancy and maintaining data integrity across all tables.

---

## 1️⃣ First Normal Form (1NF)
**Rule:**  
- Each column must contain atomic (indivisible) values.  
- Each record must be unique (identified by a primary key).  
- No repeating groups or arrays.

**Application:**
- Every table in our schema has a **primary key** (`UUID`) that uniquely identifies each record.  
- All fields store **atomic values** (e.g., a user’s name is separated into `first_name` and `last_name`, no multiple emails or phone numbers in one field).  
- No multi-valued or composite attributes exist.

✅ **All tables (User, Property, Booking, Payment, Review, Message)** satisfy **1NF**.

---

## 2️⃣ Second Normal Form (2NF)
**Rule:**  
- Must be in 1NF.  
- All non-key attributes must be fully dependent on the **entire primary key** (not just part of it).  
- No partial dependencies.

**Application:**
- Each table has a **single-attribute primary key** (`UUID`), not a composite key.  
- Therefore, no attribute depends on only part of a composite key.  
- For example:
  - In `Booking`, attributes like `start_date`, `end_date`, and `status` depend fully on `booking_id`.
  - In `Property`, all attributes depend entirely on `property_id`.

✅ **All tables are in 2NF.**

---

## 3️⃣ Third Normal Form (3NF)
**Rule:**  
- Must be in 2NF.  
- No **transitive dependencies** (non-key attributes should not depend on other non-key attributes).  
- All attributes must depend only on the primary key.

**Application:**
- **User**: Attributes like `email`, `first_name`, `role`, etc., depend only on `user_id`. No field depends on another non-key field.
- **Property**: Depends on `property_id`. Attributes like `pricepernight`, `location`, and `description` do not depend on each other.
- **Booking**: Attributes (`start_date`, `end_date`, `status`, `total_price`) depend solely on `booking_id`, not indirectly on `user_id` or `property_id`.
- **Payment**: Attributes depend only on `payment_id`; no transitive dependencies (e.g., `amount` doesn’t depend on `booking_id` data).
- **Review**: `rating` and `comment` depend only on `review_id`, not on `property_id` or `user_id`.
- **Message**: `message_body` and `sent_at` depend only on `message_id`.

✅ **All tables satisfy 3NF** — no transitive dependencies remain.

---

## 🔍 Summary of Normalization Steps

| Step | Description | Example of Enforcement |
|------|--------------|------------------------|
| **1NF** | Removed repeating groups, ensured atomic values | Split `name` into `first_name` and `last_name` |
| **2NF** | Eliminated partial dependencies | Used single-column primary keys (`UUIDs`) |
| **3NF** | Removed transitive dependencies | Ensured all non-key attributes depend only on their primary key |

---

## 💡 Design Notes
- `UUID` keys ensure global uniqueness and avoid dependency on sequential integers.
- All ENUMs (e.g., `status`, `role`, `payment_method`) enforce controlled vocabularies without creating redundant tables.
- Foreign keys (`host_id`, `booking_id`, `user_id`) maintain referential integrity between entities.
- The schema achieves **data integrity, minimal redundancy, and optimal normalization (up to 3NF)**.

---

## ✅ Conclusion
The Airbnb database design is normalized up to **Third Normal Form (3NF)**.  
This ensures:
- No redundant data
- Consistent relationships between entities
- Easy maintenance and scalability for production-level systems

---

**Author:** *[M-Wonder]*  
**Repository:** `alx-airbnb-database`  
**File:** `normalization.md`
