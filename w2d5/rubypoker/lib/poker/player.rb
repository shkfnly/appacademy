module Poker

  class Player

    def initialize(name, pot, deck)
      @name = name
      @pot = pot
      @hand_in_play = Hand.new(deck)
    end




  end
end
