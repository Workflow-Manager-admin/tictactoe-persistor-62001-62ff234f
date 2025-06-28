-- Tic Tac Toe Database Schema for PostgreSQL

-- USERS TABLE
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(64) UNIQUE NOT NULL,
    password_hash VARCHAR(128) NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now() NOT NULL
);

-- GAMES TABLE
CREATE TABLE IF NOT EXISTS games (
    id SERIAL PRIMARY KEY,
    player_x_id INTEGER REFERENCES users(id) ON DELETE SET NULL,
    player_o_id INTEGER REFERENCES users(id) ON DELETE SET NULL,
    state TEXT NOT NULL, -- JSON, stringified array or board state
    status VARCHAR(32) NOT NULL, -- e.g. 'ongoing', 'finished', 'draw'
    winner VARCHAR(2),           -- 'x', 'o', or NULL
    created_at TIMESTAMPTZ DEFAULT now() NOT NULL,
    updated_at TIMESTAMPTZ DEFAULT now() NOT NULL
);

-- Index for quick lookups of user games
CREATE INDEX IF NOT EXISTS idx_games_player_x_id ON games(player_x_id);
CREATE INDEX IF NOT EXISTS idx_games_player_o_id ON games(player_o_id);
