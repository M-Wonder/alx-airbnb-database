# Airbnb Database Schema

## Objective
Define the relational schema for the Airbnb-style database system.  
This script creates all necessary tables, relationships, and indexes based on the provided database specification.

---

## Files
- **schema.sql** – Contains all SQL statements for table creation and constraints.

---

## How to Use

### 1️⃣ Run in PostgreSQL
Ensure PostgreSQL is installed and running, then execute:

```bash
psql -U postgres -d airbnb_db -f schema.sql
