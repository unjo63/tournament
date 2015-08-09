# P2 final project: Tournament Planner
In this project, I have written a Python module that uses the PostgreSQL database to keep track of players and matches 
in a game tournament.

The game tournament will use the Swiss system for pairing up players in each round: players are not eliminated, 
and each player should be paired with another player with the same number of wins, or as close as possible.

This project has two parts: defining the database schema (SQL table definitions), and writing the code that will use it.

# Install
[Python2][] and [postgreSQL][] is required on your computer.  
[Python2]: https://www.python.org/downloads/  
[postgreSQL]: http://www.postgresql.org/download/

1. Copy tournament.py, tournament_test.py, tournament.sql in one folder.
2. Use the create database command in psql to create the database. Use the name tournament for your database.
3. Then you can connect psql to tournament database and create tables. When creat tables you can use the command \i tournament.sql to import the whole file into psql at once.

# Getting Started
Use the python tournament_test.py command.
