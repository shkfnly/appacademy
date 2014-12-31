require 'byebug'
require 'colorize'

module Chess

  class Board

    attr_reader :board, :grid, :current_pieces, :taken_pieces

    PIECES_EACH_COLOR = [:P, :P, :P, :P, :P, :P, :P, :P, :R, :R, :B, :B, :N, :N, :Q, :K]
    WHITE_STARTING_POSITIONS = [[6, 0], [6, 1], [6, 2], [6, 3], [6, 4], [6, 5], [6, 6], [6, 7],
                                [7, 0], [7, 7], [7, 2], [7, 5], [7, 1], [7, 6], [7, 3], [7, 4]]
    BLACK_STARTING_POSITIONS = [[1, 0], [1, 1], [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7],
                                [0, 0], [0, 7], [0, 2], [0, 5], [0, 1], [0, 6], [0, 3], [0, 4]]

    def initialize
      @grid = Array.new(8) { Array.new(8) { Tile.new(self) } }
      @current_pieces = { W: [], B: [] }
      @taken_pieces = { W: [], B: [] }
    end


    # Return true unless board position doesn't exist or tile is occupied by piece of same color.
    def valid_move?(piece, position)
       return false if get_position(position).nil?
       return true if piece_on_tile(position) == ''
       return false if piece_on_tile(position).color == piece.color
       true
    end

    def piece_on_tile(position)
      get_position(position).current_piece
    end

    def get_position(pos)
      x, y = pos
      return nil if ((x > 7 || x < 0) || (y > 7 || y < 0))
      @grid[x][y]
    end

    def generate_start_board
      colors = [:W, :B]
      colors.each do |color|
        start_poss = (color == :W ? WHITE_STARTING_POSITIONS : BLACK_STARTING_POSITIONS)
        PIECES_EACH_COLOR.each_with_index do |piece, i|
          pos = start_poss[i]
          tile = get_position(pos)
          case piece
          when :P
            tile.current_piece = Pawn.new(pos, color, self)
          when :R
            tile.current_piece = Rook.new(pos, color, self)
          when :B
            tile.current_piece = Bishop.new(pos, color, self)
          when :N
            tile.current_piece = Knight.new(pos, color, self)
          when :Q
            tile.current_piece = Queen.new(pos, color, self)
          when :K
            tile.current_piece = King.new(pos, color, self)
          end
          @current_pieces[color] << tile.current_piece
          tile.occupied = true
        end
      end
      8.times do |row|
        8.times do |col|
          if (row.odd? && col.odd?) || (row.even? && col.even?)
            get_position([row, col]).icon = '  '.colorize( :background => :light_cyan)
          else
            get_position([row, col]).icon = '  '.colorize( :background => :black)
          end

        end
      end
    end

    def takes_piece?(piece, position)
      return false if piece_on_tile(position) == ''
      return true if piece_on_tile(position).color != piece.color
    end

    def avoids_attack?(piece, position, color)
      results = []
      duped_board = self.deep_dup(self.grid)
      duped_board.move!(piece.position, position)
      opp_color = (color == :W ? :B : :W)
      current_pieces[opp_color].each do |piece|
        results += piece.moves
      end

      !results.include?(position)
    end

    def in_check?(color)
      king = current_pieces[color].find do |piece|
        piece.symbol == :K
      end
      results = []
      opp_color = (color == :W ? :B : :W)
      current_pieces[opp_color].each do |piece|
        results += piece.moves
      end
      results.include?(king.position)
    end

    def checkmate?(color)
      self.in_check?(color) && current_pieces[color].none? do |piece|
        piece.valid_moves(piece.moves).count > 0
      end
    end

    def move(start, dest) #return coordinates
      start_piece = piece_on_tile(start)
      moves = start_piece.moves
      valid_moves = start_piece.valid_moves(moves)
      if valid_moves.include?(dest)
        tile = get_position(dest)
        if tile.occupied?
          end_piece = tile.current_piece
          @taken_pieces[end_piece.color] << end_piece
          @current_pieces[end_piece.color].delete(end_piece)

        end
        tile.current_piece = start_piece
        tile.occupied = true
        start_piece.position = dest
        get_position(start).current_piece = ""
        get_position(start).occupied = false
        nil
      else
        raise InvalidMoveError.new "Please select a valid move"
      end
    end

    def move!(start, dest)
      start_piece = piece_on_tile(start)
      tile = get_position(dest)
      if tile.occupied?
        end_piece = tile.current_piece
        @current_pieces[end_piece.color].delete(end_piece)
      end
      tile.current_piece = start_piece
      tile.occupied = true
      start_piece.position = dest
      get_position(start).current_piece = ""
      get_position(start).occupied = false
    end

    def deep_dup(old_grid)
      duped_board = Board.new
      8.times do |i|
        8.times do |j|
          old_piece = old_grid[i][j].current_piece
          if old_piece == ''
            duped_board.grid[i][j].current_piece = old_piece
          else
            b = old_piece.class.new(old_piece.position, old_piece.color, duped_board)
            duped_board.grid[i][j].current_piece = b
            duped_board.grid[i][j].occupied = true
            duped_board.current_pieces[b.color] << b
          end
        end
      end
      duped_board
    end

    def render_taken_pieces(row, col)
      if row == 0 && col == 7
        taken_pieces[:W].each { |piece| print " #{piece.icon}" }
      elsif row == 7 && col == 7
        taken_pieces[:B].each { |piece| print " #{piece.icon}" }
      end
    end

    # def render_status(row, col, player)
    #   if row == 3 && col == 7
    #     print "Player's turn: #{player.icon}"
    #   elsif row == 4 && col == 7
    #     move_symbol = (board.valid_move? ? 'O'.colorize(:green) : 'X'.colorize(:red))
    #     print "Valid move? #{move_symbol}"
    #   end
    # end

    def render(player)
      system('clear')
      # headers = %w{0 1 2 3 4 5 6 7}
      # print '   ' + headers.join(' ')
      # puts
      8.times do |row|
        # print row.to_s + '  '
        8.times do |col|
          if grid[row][col].occupied?
            if (row.odd? && col.odd?) || (row.even? && col.even?)
              print (grid[row][col].current_piece.icon + ' ').colorize( :background => :light_cyan)
            else
              print (grid[row][col].current_piece.icon + ' ').colorize( :background => :black)
            end
          else
            print grid[row][col].icon
          end
          # render_status(row, col, player)
          render_taken_pieces(row, col)
        end
        puts
      end
    end

    def render_cursor(coords, player)
      # headers = %w{0 1 2 3 4 5 6 7}
      # print '   ' + headers.join(' ')
      # puts
      8.times do |row|
        # print row.to_s + '  '
        8.times do |col|
          if row == coords[0] && col == coords[1]
            print "  ".colorize( :background => :yellow )
          else
            if grid[row][col].occupied?
              if (row.odd? && col.odd?) || (row.even? && col.even?)
                print (grid[row][col].current_piece.icon + ' ').colorize( :background => :light_cyan)
              else
                print (grid[row][col].current_piece.icon + ' ').colorize( :background => :black)
              end
            else
              print grid[row][col].icon
            end
            # render_status(row, col, player)
            render_taken_pieces(row, col)
          end
        end
        puts
      end
    end
  end
end
