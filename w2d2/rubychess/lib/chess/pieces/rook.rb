require_relative './sliding_piece.rb'

module Chess

  class Rook < SlidingPiece

    def initialize(position, color, board)
      color == :W ? @icon = WHITE_UNICODE_PIECES[:R] : @icon = BLACK_UNICODE_PIECES[:R]
      @symbol = :R
      super(@symbol, @icon, position, color, board)
    end

    def move_dirs
      Piece::ORTHOGONAL_DIRECTIONS
    end


    def moves
      super(@position, move_dirs)
    end

  end

end
