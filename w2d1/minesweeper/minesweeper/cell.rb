require 'byebug'
require 'colorize'
module Minesweeper
  class Cell

    attr_accessor :state, :bomb, :flagged
    attr_reader :position
    #default state is blank. Can also be a bomb and a number
    DIRECTIONS = [[1, 1], [1, -1], [-1, -1], [-1, 1], [0, 1], [0, -1], [1, 0], [-1, 0]]

    def initialize(x, y)
      @state = " ".colorize(:background => :white)
      @position = [x, y]
      @bomb = false
      @flagged = false
    end

    def flag_cell
      self.flagged = true
      self.state = 'f'
    end

    def neighboring_cells
      results = []
      Cell::DIRECTIONS.each do |x, y|
        x += self.position[0]
        y += self.position[1]
        results << [x, y] unless (x > 8 || x < 0) || (y > 8 || y < 0)
      end
      results
    end

    def reveal(grid)
      cells_to_change = [self]
      cells_seen = []

      return true if self.bomb
      # otherwise look at neighbors
      until cells_to_change.empty?
        current_cell = cells_to_change.shift
        cells_seen << current_cell.position
        neighbors = current_cell.neighboring_cells

      # if no neighbors are bombs
        if neighbors.none? { |cell| grid.get_cell(cell).bomb }
          current_cell.state = "0"
          neighbors.each do |c|
            cells_to_change << grid.get_cell(c) unless cells_seen.include?(c)
          end
        else
          val = 0
          neighbors.each do |cell_pos|
            val += 1 if grid.get_cell(cell_pos).bomb
          end
          current_cell.state = val.to_s
        end
      end
    end
  end
end
