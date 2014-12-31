require_relative '../piece.rb'

module Chess

  class SteppingPiece < Piece

    def moves(position, directions)
      init_x, init_y = position
      returned_positions = []

      directions.each do |x, y|
        test_pos = [init_x + x, init_y + y]
        returned_positions << test_pos if board.valid_move?(self, test_pos)
      end

      returned_positions
    end
  end
end
