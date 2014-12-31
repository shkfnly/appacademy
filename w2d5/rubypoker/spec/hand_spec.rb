require 'spec_helper'

module Poker
  describe Hand do
    let(:deck) { Deck.new }
    let(:hand) { Hand.new(deck) }


    context "#receive_cards" do
      it "should hold a number of cards from deck" do
        5.times do
          hand.receive_card
        end
        expect(hand.current_hand.count).to eq(5)
      end

      it "should modify the deck" do
        hand.receive_card
        expect(deck.cards.count).to eq(51)
      end
    end

    context "#calculate_hand" do

      it "should return the values of a hand" do
        5.times do
          hand.receive_card
        end
        expect(hand.calculate_hand).to be_an Array
      end
    end

    context "flushes and straights" do
      let(:hand_test) { [
        Card.new(:spade, :two),
        Card.new(:spade, :three),
        Card.new(:spade, :four),
        Card.new(:spade, :five),
        Card.new(:spade, :six)
        ]}
      let(:hand_test2) { [
        Poker::Card.new(:spade, :two),
        Poker::Card.new(:heart, :three),
        Poker::Card.new(:spade, :four),
        Poker::Card.new(:spade, :king),
        Poker::Card.new(:spade, :six)
      ]}
      context "#flush?" do
        it "should return true if the hand contains a flush" do
          hand.current_hand = hand_test
          expect(hand.flush?).to eq true
        end

        it "should return false if the hand does not contain a flush" do
          hand.current_hand = hand_test2
          expect(hand.flush?).to eq false
        end
      end

      context "#straight" do
        it "should return true if the hand contains a straight" do
          hand.current_hand = hand_test
          expect(hand.straight?).to eq true
        end

        it "should return true if the hand doesn't contain a straight" do
          hand.current_hand = hand_test2
          expect(hand.straight?).to eq false
        end
      end
    end

    context "pairs, and more" do
      let(:hand2) { Hand.new(deck) }
      let(:hand_test) { [
                Card.new(:spade, :two),
                Card.new(:club, :two),
                Card.new(:spade, :four),
                Card.new(:spade, :five),
                Card.new(:spade, :six)
                ]}
      let(:hand_test2) { [
          Poker::Card.new(:spade, :three),
          Poker::Card.new(:heart, :three),
          Poker::Card.new(:club, :three),
          Poker::Card.new(:heart, :eight),
          Poker::Card.new(:spade, :six)
          ]}
      let(:hand_test3) { [
          Poker::Card.new(:spade, :three),
          Poker::Card.new(:heart, :three),
          Poker::Card.new(:club, :three),
          Poker::Card.new(:heart, :six),
          Poker::Card.new(:spade, :six)
          ]}
      let(:hand_test4) { [
          Poker::Card.new(:spade, :three),
          Poker::Card.new(:heart, :three),
          Poker::Card.new(:club, :three),
          Poker::Card.new(:diamond, :three),
          Poker::Card.new(:spade, :six)
          ]}
      context "#pairs" do
        it "should return 2 when a hand has 2 pair" do
          hand.current_hand = hand_test
          expect(hand.pairs?).to eq(1)
        end

        it "should return true when hand has 3 of a kind" do
          hand.current_hand = hand_test2
          expect(hand.three_kind?).to eq(true)
        end

        it "should return true when hand has a full house" do
          hand.current_hand = hand_test3
          expect(hand.full_house?).to eq(true)
        end

        it "should return true when hand has 4 of a kind" do
          hand.current_hand = hand_test4
          expect(hand.four_kind?).to eq(true)
        end
      end

      context "#beats?" do
        it "should return false if hand loses" do
          hand.current_hand = hand_test
          hand2.current_hand = hand_test2
          expect(hand.beats?(hand2)).to eq (false)
        end

        it "should return true if hand wins" do
          hand.current_hand = hand_test4
          hand2.current_hand = hand_test3
          expect(hand.beats?(hand2)).to eq (true)
        end
      end
    end
  end
end
