# LibraryDB Setup (pgAdmin and psql)

## Using psql
1. Install PostgreSQL (includes psql).
2. Create database:
   ```bash
   createdb LibraryDB
   ```
3. Load schema and data (one step):
   ```bash
   psql -d LibraryDB -f sql/project.sql
   ```
   Or step-by-step:
   ```bash
   psql -d LibraryDB -f sql/schema.sql
   psql -d LibraryDB -f sql/seed_data.sql
   ```
4. Run queries by sprint:
   ```bash
   psql -d LibraryDB -f sql/read_queries.sql
   psql -d LibraryDB -f sql/update_queries.sql
   psql -d LibraryDB -f sql/delete_queries.sql
   psql -d LibraryDB -f sql/advanced_queries.sql
   ```

## Using pgAdmin
1. Create database `LibraryDB` (Servers → your server → Databases → Create → Database).
2. Open Query Tool on `LibraryDB`.
3. Run `sql/project.sql` (or `sql/schema.sql` then `sql/seed_data.sql`).
4. Execute sprint files as needed (`read_queries.sql`, `update_queries.sql`, `delete_queries.sql`, `advanced_queries.sql`).

## Verify
```sql
SELECT COUNT(*) FROM authors;
SELECT COUNT(*) FROM books;
SELECT COUNT(*) FROM patrons;
```

