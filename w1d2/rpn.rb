#!/usr/bin/env ruby

class RPN
  attr_accessor :stack

  def initialize
    @stack = []
    @value = 0
    @syms = ['+', '/', '*', '-']
  end

  def parser(string)
    string = string.split(' ')
    string.each do |x|
      if @syms.include?(x)
        store = @stack.pop
        @stack << @stack.pop.send(x.to_sym, store)
      else
        @stack << x.to_i
      end
    end
    @stack.first
  end
end

if filename = ARGV[0]
  puts RPN.new.parser(File.read(filename))
end
