-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

--create table players, which has 2 column.
CREATE TABLE players ( pname TEXT, id SERIAL );
CREATE TABLE matches ( p1 SERIAL, p2 SERIAL, winner SERIAL );

CREATE VIEW match_count AS
  SELECT id, COUNT(players.id) AS games
    FROM players, matches
    WHERE players.id = matches.p1 OR players.id = matches.p2
    GROUP BY id
    ORDER BY games DESC;
CREATE VIEW win_count AS
  SELECT id, COUNT(matches.winner) AS wins
  FROM matches, players
  WHERE players.id = matches.winner
  GROUP BY id
  ORDER BY wins DESC;
--CREATE VIEW standings as