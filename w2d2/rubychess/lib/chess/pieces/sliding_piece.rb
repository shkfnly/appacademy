require_relative '../piece.rb'

module Chess

  class SlidingPiece < Piece

    def moves(position, directions) # returns an array of valid moves
      init_x, init_y = position
      returned_positions = []

      directions.each do |x, y|
        test_pos = [init_x + x, init_y + y]
        while board.valid_move?(self, test_pos)
          returned_positions << test_pos.dup
          break if board.piece_on_tile(test_pos).is_a?(Piece)
          test_pos[0] += x
          test_pos[1] += y
        end
      end

      returned_positions
    end
  end
end
