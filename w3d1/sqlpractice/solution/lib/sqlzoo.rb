require 'pg'

def execute(sql)
  conn = PG::Connection.open(:dbname => 'sqlzoo')
  conn.exec(sql).values
end
