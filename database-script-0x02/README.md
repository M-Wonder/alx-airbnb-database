# Airbnb Database – Sample Data Seeder

## Objective
Populate the Airbnb database with **realistic test data** for Users, Properties, Bookings, Payments, Reviews, and Messages.

---

## Files
- **seed.sql** – SQL script that inserts sample records into all tables.

---

## How to Use

### 1️⃣ Ensure Schema Exists
Run the schema script first:
```bash
psql -U postgres -d airbnb_db -f ../database-script-0x01/schema.sql
