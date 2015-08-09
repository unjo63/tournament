#!/usr/bin/env python
#
# tournament.py -- implementation of a Swiss-system tournament
import psycopg2


def connect():
    """Connect to the PostgreSQL database.  Returns a database connection."""
    return psycopg2.connect("dbname=tournament")


def deleteMatches():
    """Remove all the match records from the database."""
    DB = connect()
    c = DB.cursor()
    c.execute("DELETE FROM matches")
    DB.commit()
    DB.close()


def deletePlayers():
    """Remove all the player records from the database."""
    DB = connect()
    c = DB.cursor()
    c.execute("DELETE FROM players")
    DB.commit()
    DB.close()


def countPlayers():
    """Returns the number of players currently registered."""
    DB = connect()
    c = DB.cursor()
    c.execute("SELECT count (*) from players")
    result = c.fetchall()
    print "count players is returning: {}".format(result[0][0])
    return result[0][0]
    DB.close()


def registerPlayer(name):
    """Adds a player to the tournament database.

    The database assigns a unique serial id number for the player.  (This
    should be handled by your SQL database schema, not in your Python code.)

    Args:
      name: the player's full name (need not be unique).
    """
    DB = connect()
    c = DB.cursor()
    c.execute("insert into players(name) values (%s)", (name,))
    DB.commit()
    DB.close()


def playerStandings():
    """Returns a list of the players and their win records, sorted by wins.

    The first entry in the list should be the player in first place, or
    a player tied for first place if there is currently a tie.

    Returns:
      A list of tuples, each of which contains (id, name, wins, matches):
        id: the player's unique id (assigned by the database)
        name: the player's full name (as registered)
        wins: the number of matches the player has won
        matches: the number of matches the player has played
    """
    """winer:  the id number of the player who won
       loser:  the id number of the player who lost
    """
    DB = connect()
    c = DB.cursor()
    c.execute("select * from standings")
    result = c.fetchall()
    return result
    DB.close()


def reportMatch(winner, loser):
    """Adds two IDs to a row in the matches table.
       First id is winner and second id is loser in a row."""
    DB = connect()
    c = DB.cursor()
    c.execute("insert into matches(winner, loser) values (%s, %s)",
              (winner, loser,))
    DB.commit()
    DB.close()


def swissPairings():
    """Returns a list of pairs of players for the next round of a match.

    Assuming that there are an even number of players registered, each player
    appears exactly once in the pairings.  Each player is paired with another
    player with an equal or nearly-equal win record, that is, a player adjacent

    to him or her in the standings.

    Returns:
      A list of tuples, each of which contains (id1, name1, id2, name2)
        id1: the first player's unique id
        name1: the first player's name
        id2: the second player's unique id
        name2: the second player's name
    """

    PS = playerStandings()
    row = []
    for i in range(len(PS) - 1):
        if i % 2 == 0:
            row.append((PS[i][0],
                        PS[i][1],
                        PS[i + 1][0],
                        PS[i + 1][1]))
    return row
