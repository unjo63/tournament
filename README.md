# P2 final project: Tournament Planner
In this project, I have written a Python module that uses the PostgreSQL database to keep track of players and matches 
in a game tournament.

The game tournament will use the Swiss system for pairing up players in each round: players are not eliminated, 
and each player should be paired with another player with the same number of wins, or as close as possible.

This project has two parts: defining the database schema (SQL table definitions), and writing the code that will use it.

# Install
[Python2.7.10] (https://www.python.org/downloads/), [postgreSQL9.4.4] (http://www.postgresql.org/download/)
 and [psycopg2.6.1] (http://initd.org/psycopg/download/) is required on your computer.

1. Copy tournament.py, tournament_test.py, tournament.sql in one folder.
2. Use the database setup command `psql -f tournament.sql`.

# Usage
Use the command `python tournament_test.py`.
