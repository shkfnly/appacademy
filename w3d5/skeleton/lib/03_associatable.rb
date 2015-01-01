require_relative '02_searchable'
require 'active_support/inflector'
require 'byebug'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    self.class_name.constantize
  
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  attr_accessor :foreign_key, :primary_key, :class_name
  def initialize(name, options = {})
    @foreign_key = options[:foreign_key] || name.to_s.foreign_key.to_sym
    @primary_key = options[:primary_key] || :id
    @class_name =  options[:class_name]  || name.to_s.classify
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @foreign_key = options[:foreign_key] || self_class_name.foreign_key.to_sym
    @class_name =  options[:class_name]  || name.to_s.classify
    @primary_key = options[:primary_key] || :id
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
      options = BelongsToOptions.new(name, options)
      assoc_options[name] = options
    define_method(name) do
      value = self.send(options.foreign_key)
      options.model_class.where({ options.primary_key => value }).first
    end
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name, self.name, options)
    define_method(name) do
      primary_key  = self.send(options.send(:primary_key))
      p options.foreign_key
      options.model_class.where( options.foreign_key => primary_key )
    end
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
    @empty_hash = @empty_hash || {}
  end
end

class SQLObject
  extend Associatable
end
