# tictactoe-persistor-62001-62ff234f

**Tic Tac Toe Database Container**

This module defines the database schema and seed data for the Tic Tac Toe application. It supports both PostgreSQL and SQLite engines and stores user credentials and persistent game states.

---

## Schema Overview

```
+---------------------+                +-----------------------------+
|       users         |                |           games             |
+---------------------+                +-----------------------------+
| id (PK)            |<---+        +-->| id (PK)                    |
| username (unique)  |    |        |   | player_x_id (FK->users.id) |
| password_hash      |    |        |   | player_o_id (FK->users.id) |
| created_at         |    |        |   | state (JSON/Text)          |
+--------------------+     |        |   | status (ongoing/etc)       |
                           |        |   | winner (x/o/null)          |
                           +--------+   | created_at                 |
                                        | updated_at                 |
                                        +----------------------------+
```

## Table Definitions

- **users**: Stores application users.
    - `id`: integer, primary key
    - `username`: unique, not null
    - `password_hash`: hashed PW string, not null
    - `created_at`: timestamp

- **games**: Stores individual game state and participants.
    - `id`: integer, primary key
    - `player_x_id`: foreign key (users), nullable
    - `player_o_id`: foreign key (users), nullable
    - `state`: stringified board state (e.g. JSON)
    - `status`: string (ongoing, finished, draw)
    - `winner`: 'x', 'o', or null
    - `created_at`, `updated_at`: timestamps

## Usage

- **Migrations:**
    - For PostgreSQL:
        - Schema: `tic_tac_toe_database/schema_postgres.sql`
        - Seed:   `tic_tac_toe_database/seed_postgres.sql`
    - For SQLite:
        - Schema: `tic_tac_toe_database/schema_sqlite.sql`
        - Seed:   `tic_tac_toe_database/seed_sqlite.sql`
- Apply schema before running backend or any app logic.

- **Sample PSQL Command**:
    ```
    psql -U <appuser> -d <myapp> -f tic_tac_toe_database/schema_postgres.sql
    psql -U <appuser> -d <myapp> -f tic_tac_toe_database/seed_postgres.sql
    ```

- **Sample SQLite Command**:
    ```
    sqlite3 <myapp.db> < tic_tac_toe_database/schema_sqlite.sql
    sqlite3 <myapp.db> < tic_tac_toe_database/seed_sqlite.sql
    ```

## Development & Test Data

Minimal test users and games are created by the seeds for local development or testing.

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

## Notes

- For production, ensure strong password hashing (e.g., `bcrypt`).
- Timestamp fields in SQLite use `DATETIME`; in PostgreSQL, use `TIMESTAMPTZ`.
- Game `state` stores the full board as JSON or stringified array, e.g.: `["X", "O", "", ...]`
- Usernames are unique.
- Foreign keys allow graceful user deletion without orphan errors.
