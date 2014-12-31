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
      title
    FROM
      movie
    JOIN
      casting ON movie.id = casting.movieid
    JOIN
      actor ON casting.actorid = actor.id
    WHERE
      actor.name = 'Harrison Ford'
  SQL
end

def ford_supporting_films
  # List the films where 'Harrison Ford' has appeared - but not in the star
  # role. [Note: the ord field of casting gives the position of the actor. If
  # ord=1 then this actor is in the starring role]
  execute(<<-SQL)
    SELECT
      title
    FROM
      movie
    JOIN
      casting ON movie.id = casting.movieid
    JOIN
      actor ON casting.actorid = actor.id
    WHERE
      actor.name = 'Harrison Ford' AND ord != 1

  SQL
end

def films_and_stars_from_sixty_two
  # List the title and leading star of every 1962 film.
  execute(<<-SQL)
    SELECT title, name
    FROM
      movie
    JOIN
      casting ON movie.id = casting.movieid
    JOIN
      actor ON casting.actorid  = actor.id
    WHERE
      ord = 1 AND yr = 1962
  SQL
end

def travoltas_busiest_years
  # Which were the busiest years for 'John Travolta'? Show the year and the
  # number of movies he made for any year in which he made at least 2 movies.
  execute(<<-SQL)
    SELECT
      yr, COUNT(title)
    FROM
      movie
    JOIN
      casting ON movie.id = casting.movieid
    JOIN
      actor ON casting.actorid  = actor.id
    WHERE
      actor.name = 'John Travolta'
    GROUP BY
      yr
    HAVING
      COUNT(title) > 1

  SQL
end

#ASK FOR HELP ON THIS

def andrews_films_and_leads
  # List the film title and the leading actor for all of the films 'Julie
  # Andrews' played in.
  execute(<<-SQL)
    SELECT
      title, name
    FROM
      movie m
    JOIN
      casting c ON m.id = c.movieid
    JOIN
      actor a ON c.actorid = a.id
    WHERE ord = 1 AND title IN (SELECT title
                                FROM movie
                                JOIN casting ON movie.id = casting.movieid
                                JOIN actor ON casting.actorid = actor.id
                                WHERE
                                actor.name = 'Julie Andrews')
  SQL
end

def prolific_actors
  # Obtain a list in alphabetical order of actors who've had at least 15
  # starring roles.
  execute(<<-SQL)
    SELECT
      name
    FROM
      actor a
    JOIN
      casting c ON a.id = c.actorid
    JOIN
      movie m ON c.movieid = m.id
    WHERE
      c.ord = 1
    GROUP BY
      name
    HAVING
      COUNT(m.title) > 14
    ORDER BY
      name
  SQL
end

def films_by_cast_size
  # List the films released in the year 1978 ordered by the number of actors
  # in the cast (descending), then by title (ascending).
  execute(<<-SQL)
    SELECT
      title, COUNT(c.actorid)
    FROM
      movie m
    JOIN
      casting c ON m.id = c.movieid
    JOIN
      actor a ON c.actorid = a.id
    WHERE
     yr = 1978
    GROUP BY
      title
    ORDER BY COUNT(c.actorid) DESC, title

  SQL
end

def colleagues_of_garfunkel
  # List all the people who have worked with 'Art Garfunkel'.
  execute(<<-SQL)
    SELECT
      name
    FROM
      movie m
    JOIN
      casting c ON m.id = c.movieid
    JOIN
      actor a ON c.actorid = a.id
    WHERE
      m.id IN (SELECT movie.id
               FROM movie
               JOIN casting ON movie.id = casting.movieid
               JOIN actor ON casting.actorid = actor.id
               WHERE actor.name = 'Art Garfunkel') AND name != 'Art Garfunkel'
  SQL
end
