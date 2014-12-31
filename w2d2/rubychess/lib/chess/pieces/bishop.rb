require_relative './sliding_piece.rb'

module Chess

  class Bishop < SlidingPiece

    def initialize(position, color, board)
      color == :W ? @icon = WHITE_UNICODE_PIECES[:B] : @icon = BLACK_UNICODE_PIECES[:B]
      @symbol = :B
      super(@symbol, @icon, position, color, board)
    end

    def move_dirs
      Piece::DIAGONAL_DIRECTIONS
    end

    def moves
      super(@position, move_dirs)
    end
  end

end
