require_relative './sliding_piece.rb'

module Chess

  class Queen < SlidingPiece

    def initialize(position, color, board)
      color == :W ? @icon = WHITE_UNICODE_PIECES[:Q] : @icon = BLACK_UNICODE_PIECES[:Q]
      @symbol = :Q
      super(@symbol, @icon, position, color, board)
    end

    def move_dirs
      Piece::ORTHOGONAL_DIRECTIONS + Piece::DIAGONAL_DIRECTIONS
    end

    def moves
      super(@position, move_dirs)
    end

  end

end
