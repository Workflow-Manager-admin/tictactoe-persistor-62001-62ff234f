-- Tic Tac Toe Database Schema for SQLite

-- USERS TABLE
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- GAMES TABLE
CREATE TABLE IF NOT EXISTS games (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    player_x_id INTEGER,
    player_o_id INTEGER,
    state TEXT NOT NULL, -- JSON, stringified array or board state
    status TEXT NOT NULL, -- 'ongoing', 'finished', 'draw'
    winner TEXT,          -- 'x', 'o', or NULL
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY(player_x_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY(player_o_id) REFERENCES users(id) ON DELETE SET NULL
);

-- Index for quick lookups of user games
CREATE INDEX IF NOT EXISTS idx_games_player_x_id ON games(player_x_id);
CREATE INDEX IF NOT EXISTS idx_games_player_o_id ON games(player_o_id);
