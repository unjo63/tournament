-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

--set up the tournament database.
DROP DATABASE IF EXISTS tournament;
CREATE DATABASE tournament;
\c tournament

--create table players, which has 2 column.
CREATE TABLE players(name TEXT, id SERIAL PRIMARY KEY);

--create table matches, which has 2 column.
--CREATE TABLE matches(winner SERIAL, loser SERIAL,
--                        PRIMARY KEY(winner,loser));
CREATE TABLE matches(
   match_id SERIAL PRIMARY KEY,
   winner INTEGER REFERENCES players(id),
   loser INTEGER REFERENCES players(id)
   CHECK (winner <> loser)
);

--create view match_count, which has 2 column player id
--and his or her match count.
CREATE VIEW match_count AS
  SELECT id, COUNT(players.id) AS played
    FROM players, matches
    WHERE players.id = matches.winner OR players.id = matches.loser
    GROUP BY id
    ORDER BY played DESC;

--create view win_count, which has 2 column player id
--and his or her win count.
CREATE VIEW win_count AS
  SELECT id, COUNT(matches.winner) AS wins
  FROM players, matches
  WHERE players.id = matches.winner
  GROUP BY id
  ORDER BY wins DESC;

--create view standings, which has 4 column player id,
--his or her name, win count and match count.
 CREATE VIEW standings AS
  SELECT players.id, players.name,
  coalesce(win_count.wins,0) as wins,
  coalesce(match_count.played,0) as played
  FROM players
  LEFT JOIN win_count
  ON players.id = win_count.id
  LEFT JOIN match_count
  ON players.id = match_count.id
  ORDER BY wins DESC;
