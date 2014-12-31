require 'colorize'
require 'byebug'

require_relative "./chess/tile.rb"
require_relative "./chess/piece.rb"
require_relative "./chess/board.rb"
require_relative "./chess/pieces/bishop.rb"
require_relative "./chess/pieces/king.rb"
require_relative "./chess/pieces/knight.rb"
require_relative "./chess/pieces/pawn.rb"
require_relative "./chess/pieces/queen.rb"
require_relative "./chess/pieces/rook.rb"
require_relative "./chess/pieces/sliding_piece.rb"
require_relative "./chess/pieces/stepping_piece.rb"
require_relative "./chess/game.rb"
require_relative "./chess/player.rb"



module Chess

  WHITE_UNICODE_PIECES = {
    :K => "\u265A".encode("UTF-8"),
    :Q => "\u265B".encode("UTF-8"),
    :B => "\u265D".encode("UTF-8"),
    :R => "\u265C".encode("UTF-8"),
    :N => "\u265E".encode("UTF-8"),
    :P => "\u265F".encode("UTF-8")
  }

  BLACK_UNICODE_PIECES = {
    :K => "\u2654".encode("UTF-8"),
    :Q => "\u2655".encode("UTF-8"),
    :B => "\u2657".encode("UTF-8"),
    :R => "\u2656".encode("UTF-8"),
    :N => "\u2658".encode("UTF-8"),
    :P => "\u2659".encode("UTF-8")
  }

  class InvalidMoveError < ArgumentError
  end

end


b = Chess::Game.new
b.start(b.prompt_player)
