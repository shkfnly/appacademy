# == Schema Information
#
# Table name: stops
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: route 
#
#  num         :integer      not null, primary key
#  company     :string       not null, primary key
#  pos         :integer      not null, primary key
#  stop        :integer

require_relative './sqlzoo.rb'

def num_stops
  # How many stops are in the database?
  execute(<<-SQL)
    SELECT
      COUNT(DISTINCT(route.stop))
    FROM
      route;
  SQL
end

def craiglockhart_id
  # Find the id value for the stop 'Craiglockhart'.
  execute(<<-SQL)
    SELECT
      stops.id
    FROM
      stops
    WHERE
      stops.name = 'Craiglockhart';
  SQL
end

def lrt_stops
  # Give the id and the name for the stops on the '4' 'LRT' service.
  execute(<<-SQL)
    SELECT
      route.stop, stops.name
    FROM
      route
    JOIN
      stops ON route.stop = stops.id
    WHERE
      route.company = 'LRT'
      AND route.num = '4';
  SQL
end  

def connecting_routes
  # The query shown gives the number of routes that visit either London Road
  # (149) or Craiglockhart (53). Run the query and notice the two services
  # that link these stops have a count of 2. Add a HAVING clause to restrict
  # the output to these two routes.
  execute(<<-SQL)
    SELECT
      company, num, COUNT(*)
    FROM
      route
    WHERE
      stop=149 OR stop=53
    GROUP BY
      company, num
  SQL
end

def cl_to_lr
  # Execute the self join shown and observe that b.stop gives all the places
  # you can get to from Craiglockhart, without changing routes. Change the
  # query so that it shows the services from Craiglockhart to London Road.
  execute(<<-SQL)
    SELECT
      a.company, a.num, a.stop, b.stop
    FROM
      route a
    JOIN
      route b ON (a.company=b.company AND a.num=b.num)
    WHERE
      a.stop=53
  SQL
end

def cl_to_lr_by_name
  # The query shown is similar to the previous one, however by joining two
  # copies of the stops table we can refer to stops by name rather than by
  # number. Change the query so that the services between 'Craiglockhart' and
  # 'London Road' are shown. If you are tired of these places try
  # 'Fairmilehead' against 'Tollcross'
  execute(<<-SQL)
    SELECT
      a.company, a.num, stopa.name, stopb.name
    FROM
      route a
    JOIN
      route b ON (a.company=b.company AND a.num=b.num)
    JOIN
      stops stopa
    ON (a.stop=stopa.id)
    JOIN
      stops stopb ON (b.stop=stopb.id)
    WHERE
      stopa.name='Craiglockhart'
  SQL
end

def haymarket_and_leith
  # Give a list of all the services which connect stops 115 and 137
  # ('Haymarket' and 'Leith')
  execute(<<-SQL)
    SELECT
      DISTINCT r1.company, r1.num
    FROM (
        SELECT
          r1.company, r1.num
        FROM
          route r1
        JOIN
          stops s1 ON r1.stop = s1.id
        WHERE
          s1.name = 'Haymarket'
      ) AS r1
    JOIN (
        SELECT
          r2.company, r2.num, s2.name
        FROM
          route r2
        JOIN
          stops s2 ON r2.stop = s2.id
        WHERE
          s2.name = 'Leith'
      ) AS r2 ON (r1.company = r2.company AND r1.num = r2.num)
  SQL
end

def craiglockhart_and_tollcross
  # Give a list of the services which connect the stops 'Craiglockhart' and
  # 'Tollcross'
  execute(<<-SQL)
    SELECT
      r1.company, r1.num
    FROM (
        SELECT
          r1.company, r1.num
        FROM
          route r1
        JOIN
          stops s1 ON r1.stop = s1.id
        WHERE
          s1.name = 'Craiglockhart'
      ) AS r1
    JOIN (
        SELECT
          r2.company, r2.num, s2.name
        FROM
          route r2
        JOIN
          stops s2 ON r2.stop = s2.id
        WHERE s2.name = 'Tollcross'
      ) AS r2 ON (r1.company = r2.company AND r1.num = r2.num);
  SQL
end

def start_at_craiglockhart
  # Give a distinct list of the stops which may be reached from 'Craiglockhart'
  # by taking one bus, including 'Craiglockhart' itself. Include the company
  # and bus no. of the relevant services.
  execute(<<-SQL)
    SELECT
      end_route_stops.name,
      end_routes.company,
      end_routes.num
    FROM (
        SELECT
          *
        FROM
          route start_routes
        WHERE
          start_routes.stop = (
            SELECT
              stops.id
            FROM
              stops
            WHERE
              stops.name = 'Craiglockhart'
          )
      ) AS start_routes
    JOIN
      route AS end_routes ON
        (start_routes.num = end_routes.num
        AND start_routes.company = end_routes.company)
    JOIN
      stops AS end_route_stops ON end_routes.stop = end_route_stops.id
  SQL
end

def craiglockhart_to_sighthill
  # Find the routes involving two buses that can go from Craiglockhart to
  # Sighthill. Show the bus no. and company for the first bus, the name of the
  # stop for the transfer, and the bus no. and company for the second bus.
  execute(<<-SQL)
    SELECT DISTINCT
      start.num, start.company, transfer.name, finish.num, finish.company
    FROM
      route start
    JOIN
      route AS to_transfer ON
        (start.company = to_transfer.company AND start.num = to_transfer.num)
    JOIN
      stops AS transfer ON
        (to_transfer.stop = transfer.id)
    JOIN
      route AS from_transfer ON
        (transfer.id = from_transfer.stop)
    JOIN
      route AS finish ON
        (from_transfer.company = finish.company AND from_transfer.num = finish.num)
    WHERE
      start.stop = (
        SELECT
          id
        FROM
          stops
        WHERE
          name = 'Craiglockhart'
      ) AND finish.stop = (
        SELECT
          id
        FROM
          stops
        WHERE
          name = 'Sighthill'
      )
  SQL
end
