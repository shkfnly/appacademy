module Poker
  class Hand

    HAND_RANKINGS = {
      :high_card        =>  1,
      :pair             =>  2,
      :two_pair         =>  3,
      :three_of_a_kind  =>  4,
      :straight         =>  5,
      :flush            =>  6,
      :full_house       =>  7,
      :four_of_a_kind   =>  8,
      :straight_flush   =>  9,
      :royal_flush      =>  10
    }

    attr_reader :deck
    attr_accessor :current_hand

    def hand_rank
      return :royal_flush       if royal_flush?
      return :straight_flush    if straight_flush?
      return :four_of_a_kind    if four_kind?
      return :full_house        if full_house?
      return :flush             if flush?
      return :straight          if straight?
      return :three_of_a_kind   if three_kind?
      return :two_pair          if pairs? == 2
      return :pair              if pairs? == 1
      :high_card
    end


    def initialize(deck)
      @deck = deck
      @current_hand = []
      @hand_value
    end

    def receive_card
      @current_hand.concat(@deck.deal(1))
    end

    def calculate_hand
      @current_hand.map do |card|
        card.poker_value
      end
    end

    def count_cards
      card_count = Hash.new(0)
      @current_hand.each { |card| card_count[card.value] += 1}
      card_count
    end

    def pairs?
      count_cards.select { |k, v| v == 2}.count
    end

    def three_kind?
      count_cards.any? { |k, v| v == 3}
    end

    def straight?
      sorted_hand = @current_hand.sort_by { |card| card.value}
      sorted_hand.inject(0) do |sum, card|
        sum += @current_hand[0].poker_value - card.poker_value
      end == -10
    end

    def flush?
      @current_hand.map { |card| card.suit}.uniq.count == 1
    end

    def full_house?
      three_kind? && pairs? == 1
    end

    def four_kind?
      count_cards.any? { |k, v| v == 4}
    end

    def straight_flush?
      straight? && flush?
    end

    def royal_flush?
      current_hand.any? { |card| card.value == (:ace) } &&
      straight_flush?
    end

    def beats?(other_hand)
      HAND_RANKINGS[hand_rank] > HAND_RANKINGS[other_hand.hand_rank]
    end

    def tie?(other_hand)
      if HAND_RANKINGS[hand_rank] == HAND_RANKINGS[other_hand.hand_rank]
    end

    def tie_breaker
      max = count_cards.values.max
      count_cards.select do |k,v| v == max
      end.keys.map {|value| Card::VALUES[value]}.max
    end

  end
end
