-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

--create table players, which has 2 column.
CREATE TABLE players ( name TEXT, id SERIAL primary key );
CREATE TABLE matches ( winner SERIAL, loser SERIAL,
PRIMARY KEY(winner,loser) );

CREATE VIEW match_count AS
  SELECT id, COUNT(players.id) AS played
    FROM players, matches
    WHERE players.id = matches.winner OR players.id = matches.loser
    GROUP BY id
    ORDER BY played DESC;

CREATE VIEW win_count AS
  SELECT id, COUNT(matches.winner) AS wins
  FROM players, matches
  WHERE players.id = matches.winner
  GROUP BY id
  ORDER BY wins DESC;

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