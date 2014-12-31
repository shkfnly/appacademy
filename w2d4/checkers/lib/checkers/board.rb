require 'colorize'

module Checkers

  class Board

    attr_accessor :grid, :pieces
    
    def initialize
      @grid = Array.new(8){ Array.new(8){ nil}}
      @pieces = {r: 0, b: 0}
    end

    def create_initial_board
      generate_new_board
    end

    def piece_count_by_color(sym)
      pieces(sym)
    end

    def remove_piece(opp_sym)
      opp_sym == :r ? del_sym = :b : del_sym = :r
      pieces[del_sym] -= 1
    end

    def at_position(pos)
      x, y = pos
      return nil if (x > 7 || y > 7) || (x < 0 || y < 0)
      @grid[x][y]
    end

    def set_position(pos, value)
      x, y = pos
      @grid[x][y] = value
    end

    def self.valid_pos?(pos)
      pos.all? { |coord| coord.between?(0, 7)}
    end

    def render
      headers = %w{0 1 2 3 4 5 6 7}
      print '   ' + headers.join(' ')
      puts
      8.times do |row|
        print (row.to_s + ' ')
        8.times do |col|
          if (row.odd? && col.odd?) || (row.even? && col.even?)
            print '  '.colorize( :background => :red)
          else
            if grid[row][col].nil?
              print '  '.colorize( :background => :white)
            else
              print (self.at_position([row, col]).icon + ' ').colorize(:background => :white)
            end
          end
        end
        puts
      end
    end

    def dup_board
      duped_board = Board.new
      (duped_board.grid.count).times do |row|
        (duped_board.grid.count).times do |col|
          eval = self.at_position([row, col])
          if eval.is_a? Piece
            p = Piece.new(eval.color, eval.position, duped_board, eval.king)
          end
        end
      end
      duped_board
    end

    private


      def generate_new_board
        colors = {r: [0, 1, 2], 
                  b: [5, 6, 7]}

        [:r, :b].each do |color|
          colors[color].each do |row|
            8.times do |col|
              if (row.even? && col.odd?) || (row.odd? && col.even?)
                Piece.new(color, [row, col], self)
                pieces[color] += 1
              end
            end
          end
        end
      end

  end
end
