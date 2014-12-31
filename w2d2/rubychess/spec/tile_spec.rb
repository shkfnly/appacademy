require "spec_helper"


module Chess
  describe Tile do

    let (:board) { Board.new}

    context "#initialize" do
      it "is initialized with a value of '' by default" do
        cell = Tile.new(:board)
        expect(cell.value).to eq ''
      end

      it "is initialized with a board by default" do
        cell = Tile.new(:board)
        expect(cell.board).not_to be_nil
      end
    end

    context "#occupied?" do
      it "should initialize empty" do
        cell = Tile.new(:board)
        expect(cell.occupied).to eq false
      end
    end

  end
end
