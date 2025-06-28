# Tic Tac Toe Database Container

This container provides persistent data storage for the Tic Tac Toe app, hosting PostgreSQL (and optionally SQLite) databases containing users and games.

---

## Quick Start

1. **Run/PostgreSQL Startup:**

   - Use the script:
     ```bash
     bash tic_tac_toe_database/startup.sh
     ```
     This will initialize PostgreSQL, create needed users, and set up the database at port `5000`.

2. **Database Connection Info:**

   - **Connection String (default for dev):**
     ```
     psql postgresql://appuser:dbuser123@localhost:5000/myapp
     ```
   - These variables are set in `db_visualizer/postgres.env`:
     ```
     export POSTGRES_URL="postgresql://localhost:5000/myapp"
     export POSTGRES_USER="appuser"
     export POSTGRES_PASSWORD="dbuser123"
     export POSTGRES_DB="myapp"
     export POSTGRES_PORT="5000"
     ```

3. **Schema & Seed Data:**

   - Schemas are in:
     - `tic_tac_toe_database/schema_postgres.sql` (for PostgreSQL)
     - `tic_tac_toe_database/schema_sqlite.sql` (for SQLite testing)
   - Example commands:
     ```bash
     # For PostgreSQL:
     psql -U appuser -d myapp -p 5000 -f tic_tac_toe_database/schema_postgres.sql
     psql -U appuser -d myapp -p 5000 -f tic_tac_toe_database/seed_postgres.sql

     # For SQLite:
     sqlite3 myapp.db < tic_tac_toe_database/schema_sqlite.sql
     sqlite3 myapp.db < tic_tac_toe_database/seed_sqlite.sql
     ```

---

## Environment Variables

**Sample (`.env` or shell export):**
```
POSTGRES_URL=postgresql://appuser:dbuser123@localhost:5000/myapp
POSTGRES_USER=appuser
POSTGRES_PASSWORD=dbuser123
POSTGRES_DB=myapp
POSTGRES_PORT=5000
```
- These are required for the backend and any service connecting to the DB.

---

## Schema Diagram

```mermaid
erDiagram
    users {
        INTEGER id PK
        VARCHAR username UNIQUE
        VARCHAR password_hash
        TIMESTAMP created_at
    }
    games {
        INTEGER id PK
        INTEGER player_x_id FK
        INTEGER player_o_id FK
        TEXT state
        VARCHAR status
        VARCHAR winner
        TIMESTAMP created_at
        TIMESTAMP updated_at
    }
    users ||--o{ games : player_x_id
    users ||--o{ games : player_o_id
```

---

## Port Usage

- **Database (Postgres)**: `5000` (changeable via `POSTGRES_PORT`)
- **DB Visualizer**: `3000` (Node.js viewer at `db_visualizer/server.js`)

---

## Advanced

- The startup script sets up all permissions and saves connection info in `db_connection.txt`.
- Direct environment settings for use with Node.js (if using the visualizer or migrations).
- The DB allows connections from backend and any developer tools with correct credentials.

---

## Cross-Container Notes

- This DB is designed for use with the Tic Tac Toe backend (`POSTGRES_*` vars).
- Change/clone the sample `.env` values for secure production deployments.
- The provided backend/service containers expect the schema to be present, so provision on first run.

---

## Troubleshooting

- If connection fails, make sure container/network port `5000` is accessible and user credentials from `.env` are correct.

---
