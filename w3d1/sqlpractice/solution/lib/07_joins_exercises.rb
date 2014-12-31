# == Schema Information
#
# Table name: actor
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: movie
#
#  id          :integer      not null, primary key
#  title       :string
#  yr          :integer
#  score       :float
#  votes       :integer
#  director    :integer
#
# Table name: casting
#
#  movieid     :integer      not null, primary key
#  actorid     :integer      not null, primary key
#  ord         :integer

require_relative './sqlzoo.rb'

def example_join
  execute(<<-SQL)
    SELECT
      *
    FROM
      movie
    JOIN
      casting ON movie.id = casting.movieid
    JOIN
      actor ON casting.actorid = actor.id
    WHERE
      actor.name = 'Sean Connery'
  SQL
end

def ford_films
  # List the films in which 'Harrison Ford' has appeared.
  execute(<<-SQL)
    SELECT
      movie.title
    FROM
      movie
    JOIN
      casting ON casting.movieid = movie.id
    JOIN
      actor ON actor.id = casting.actorid
    WHERE
      actor.name = 'Harrison Ford';
  SQL
end

def ford_supporting_films
  # List the films where 'Harrison Ford' has appeared - but not in the star
  # role. [Note: the ord field of casting gives the position of the actor. If
  # ord=1 then this actor is in the starring role]
  execute(<<-SQL)
    SELECT
      movie.title
    FROM
      movie
    JOIN
      casting ON casting.movieid = movie.id
    JOIN
      actor ON actor.id = casting.actorid
    WHERE
      (actor.name = 'Harrison Ford' AND casting.ord != 1);
  SQL
end

def films_and_stars_from_sixty_two
  # List the title and leading star of every 1962 film.
  execute(<<-SQL)
    SELECT
      movie.title, actor.name
    FROM
      movie
    JOIN
      casting ON casting.movieid = movie.id
    JOIN
      actor ON actor.id = casting.actorid
    WHERE
      (movie.yr = 1962 AND casting.ord = 1);
  SQL
end

def travoltas_busiest_years
  # Which were the busiest years for 'John Travolta'? Show the year and the
  # number of movies he made for any year in which he made at least 2 movies.
  execute(<<-SQL)
    SELECT
      movie.yr, COUNT(*)
    FROM
      movie
    JOIN
      casting ON casting.movieid = movie.id
    JOIN
      actor ON actor.id = casting.actorid
    WHERE
      actor.name = 'John Travolta'
    GROUP BY
      movie.yr
    HAVING
      COUNT(*) >= 2;
  SQL
end

def andrews_films_and_leads
  # List the film title and the leading actor for all of the films 'Julie
  # Andrews' played in.
  execute(<<-SQL)
    SELECT
      DISTINCT m1.title, a1.name
    FROM (
        SELECT
          movie.*
        FROM
          movie
        JOIN
          casting ON casting.movieid = movie.id
        JOIN
          actor ON actor.id = casting.actorid
        WHERE
          actor.name = 'Julie Andrews'
      ) AS m1
    JOIN (
        SELECT
          actor.*, casting.movieid AS movieid
        FROM
          actor
        JOIN
          casting ON casting.actorid = actor.id
        WHERE
          casting.ord = 1
      ) AS a1 ON m1.id = a1.movieid
    ORDER BY
      m1.title;
  SQL
end

def prolific_actors
  # Obtain a list in alphabetical order of actors who've had at least 15
  # starring roles.
  execute(<<-SQL)
    SELECT
      actor.name
    FROM
      actor
    JOIN
      casting ON casting.actorid = actor.id
    JOIN
      movie ON movie.id = casting.movieid
    WHERE
      casting.ord = 1
    GROUP BY
      actor.name
    HAVING
      COUNT(*) >= 15
    ORDER BY
      actor.name;
  SQL
end

def films_by_cast_size
  # List the films released in the year 1978 ordered by the number of actors
  # in the cast (descending), then by title (ascending).
  execute(<<-SQL)
    SELECT
      movie.title, COUNT(DISTINCT casting.actorid) AS actor_count
    FROM
      movie
    JOIN
      casting ON casting.movieid = movie.id
    WHERE
      movie.yr = 1978
    GROUP BY
      movie.id
    ORDER BY
      COUNT(*) DESC, movie.title ASC;
  SQL
end

def colleagues_of_garfunkel
  # List all the people who have worked with 'Art Garfunkel'.
  execute(<<-SQL)
    SELECT
      a1.name
    FROM (
        SELECT
          movie.*
        FROM
          movie
        JOIN
          casting ON casting.movieid = movie.id
        JOIN
          actor ON actor.id = casting.actorid
        WHERE
          actor.name = 'Art Garfunkel'
      ) AS m1
    JOIN (
        SELECT
          actor.*, casting.movieid
        FROM
          actor
        JOIN
          casting ON casting.actorid = actor.id
        WHERE
          actor.name != 'Art Garfunkel'
      ) AS a1 ON m1.id = a1.movieid;
  SQL
end
