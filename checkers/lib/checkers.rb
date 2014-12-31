require 'byebug'

require_relative "checkers/version"
require_relative './checkers/piece.rb'
require_relative './checkers/board.rb'
require_relative './checkers/game.rb'
require_relative './checkers/player.rb'

module Checkers
  # Your code goes here...

  class InvalidMoveError < ArgumentError
  end

  class InvalidNumberofPlayers < ArgumentError
  end

end


