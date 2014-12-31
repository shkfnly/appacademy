require "spec_helper"

module Poker
  describe Deck do
    let(:deck) {Deck.new}
    context "#initialize" do
      it "should initialize with 52 cards" do
        expect(deck.cards.count).to eq (52)
      end
    end

    context "#deal" do
        let(:a) {deck.deal(2)}
      it "should take a number of cards and return an array" do

        expect(a).to be_an Array
        expect(a.first).to be_a Card
        expect(a.last).to be_a Card
        expect(a.count).to eq(2)
      end

      it "should modify the deck of cards" do
        deck.deal(2)
        expect(deck.cards.length).to eq(50)
      end
    end

    context "#return" do
      let(:a) { [Card.new(:club, :ace), Card.new(:spade,:ace)] }
      it "should return cards to the deck" do
        deck.return(a)
        expect(deck.cards.count).to eq(54)
      end

    end

  end
end
