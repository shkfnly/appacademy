require 'byebug'

module Chess

  class Piece

    DIAGONAL_DIRECTIONS = [
      [1, 1],
      [1, -1],
      [-1, 1],
      [-1, -1]
    ]
    ORTHOGONAL_DIRECTIONS = [
      [0, 1],
      [0, -1],
      [-1, 0],
      [1, 0]
    ]

    attr_reader :color, :symbol, :board, :icon
    attr_accessor :position

    def initialize(symbol, icon, position, color, board)
      @symbol = symbol
      @icon = icon
      @position = position
      @color = color
      @board = board
    end

    def inspect
      "#{@symbol}, #{@position}, #{@color}"
    end

    def valid_moves(moves) #return array of valid moves
      result = []
      moves.each do |test_move|
        duped_board = board.deep_dup(board.grid)

        duped_board.move!(self.position, test_move)
        result << test_move unless duped_board.in_check?(color)
      end
      result
    end

  end
end
