-- Seed data for SQLite

-- Users
INSERT INTO users (username, password_hash) VALUES
('alice', 'pbkdf2$sha256$150000$saltsalt$hashhashhash');
INSERT INTO users (username, password_hash) VALUES
('bob', 'pbkdf2$sha256$150000$saltybob$hashbobhash');

-- Games
INSERT INTO games (player_x_id, player_o_id, state, status, winner)
VALUES (
    1, 2,
    '["X","","O","X","O","","","",""]',
    'ongoing',
    NULL
);
INSERT INTO games (player_x_id, player_o_id, state, status, winner)
VALUES (
    2, 1,
    '["O","X","O","X","X","O","O","X","X"]',
    'finished',
    'x'
);
