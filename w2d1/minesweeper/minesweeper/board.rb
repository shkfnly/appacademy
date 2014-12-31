require 'yaml'
require 'colorize'

module Minesweeper
  class Board

    attr_accessor :grid, :get_cell, :grid

    def initialize
      @grid  = []
      (0...9).each do |x|
        a = []
        (0...9).each do |y|
          a[y] = Cell.new(x, y)
        end
        @grid << a
      end
      place_bombs(30)
    end

    def get_cell(position)
      x , y = position
      @grid[x][y]
    end

    def show_bombs
      (0...9).each do |i|
        (0...9).each do |j|
          cell = get_cell([i,j])
          cell.state = "X".colorize(:red) if cell.bomb
          cell.state = "@".colorize(:yellow) if cell.bomb && cell.flagged
        end
      end
      render
    end

    def render
      headers = %w{0 1 2 3 4 5 6 7 8}
      print (['  '] + headers).join(' ')
      print "\n"
      (0...9).each do |i|
         printer = []
         self.grid[i].each do |cell|
          printer << cell.state
        end
        print i
        puts ([" "] + printer).join(' ')
        print "\n"
      end
    end

    def flag_cell(pos)
      get_cell(pos).flag_cell
    end


    def play_move(pos_array)
      g = get_cell(pos_array)
      # g.reveal(self)
      if g.reveal(self) == true
        show_bombs
        puts "SUCKS FOR YOUUUUUU!! Game Over!"
        exit
      end
    end

    private

    def place_bombs(difficulty)
      positions = []
      until positions.count == difficulty
        x = (0...9).to_a.sample
        y = (0...9).to_a.sample
        positions << [x, y] unless positions.include?([x, y])
      end
      positions.each do |x, y|
        get_cell([x, y]).bomb = true
      end
    end
  end
end
