
module Poker
  class Deck

    attr_accessor :cards

    def initialize
      @cards = all_cards.shuffle
    end

    def all_cards
      cards = []
      Card::SUITS.each do |suit|
        Card::VALUES.keys.each do |value|
          cards << Card.new(suit, value)
        end
      end
      cards
    end

    def deal(n)
      cards.shift(n)
    end

    def return(hand)
      cards.concat(hand)
    end


    def shuffle
      @cards.shuffle!
    end


  end
end
