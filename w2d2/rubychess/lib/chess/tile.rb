require 'colorize'

module Chess
  class Tile
    attr_reader :board
    attr_accessor :current_piece, :occupied, :icon

    def initialize(board)
      @icon = ' '
      @board = board
      @current_piece = ''
      @occupied = false
    end

    def occupied?
      @occupied
    end

  end
end
