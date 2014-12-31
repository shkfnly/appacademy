require "spec_helper"

module Poker
  describe Card do
    let(:card) {Card.new(:h, :two)}
    context "#intialize" do
      it "should initialize with a suit" do
        expect(card.suit).to eq(:h)
      end

      it "should initialize with a value" do
        expect(card.value).to eq(:two)
      end

      it "should return a poker value" do
        expect(card.poker_value).to be_an Integer
        expect(card.poker_value).to eq(2)
      end

    end
  end

  
end
