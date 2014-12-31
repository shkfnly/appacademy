require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    DBConnection.execute2("SELECT * FROM #{self.table_name}")
    .first.map(&:to_sym)
  end

  def self.finalize!
    self.columns.each do |column|
      define_method("#{column}") { attributes["#{column}".to_sym]}
      define_method("#{column}=") do |value| 
        attributes["#{column}".to_sym] = value
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name || self.to_s.tableize
  end

  def self.all
    parse_all(DBConnection.execute("SELECT #{self.table_name}.* FROM #{self.table_name}"))
  end

  def self.parse_all(results)
    set_class = self
    results.map do |obj|
      set_class.new(obj)
    end
  end

  def self.find(id)
    result = DBConnection.execute(<<-SQL, id)
      SELECT 
        #{self.table_name}.* 
      FROM 
        #{self.table_name} 
      WHERE id = ?
      SQL
    return nil if result.empty?
    parse_all(result).first
  end

  def initialize(params = {})
    # ...
    params.each do |attr_name, value|
      symb = attr_name.to_sym
      raise "unknown attribute '#{attr_name}'" unless self.class.columns.include?(symb)
      self.send("#{attr_name}=", value)
    end
  end

  def attributes
    @attributes = @attributes || {} 
    # ...
  end

  def attribute_values
    self.class.columns.map do |name|
      self.send(name)
    end
  end

  def insert
    column_names = self.class.columns.join(', ')
    question_marks = (["?"] * self.class.columns.length).join(', ')

    DBConnection.execute(<<-SQL, *attribute_values)
    INSERT INTO 
      #{self.class.table_name} (#{column_names}) 
    VALUES
      (#{question_marks})
    SQL
    id = DBConnection.last_insert_row_id
    self.send(:id=, id)
  end

  def update
    set_line = self.class.columns.map do |attr_name|
        "#{attr_name} = ?"
      end.join(', ')
    DBConnection.execute(<<-SQL, *attribute_values)
      UPDATE
        #{self.class.table_name}
      SET
        #{set_line}
      WHERE
        id = #{self.id}
    SQL
  end

  def save
    id.nil? ? insert : update
  end
end
