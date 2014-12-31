require "spec_helper"

module Checkers
  # let (:symbol) { block to define what it equals}
    
  describe Piece do

    let (:board) {Checkers::Board.new}
    # context "#initialize" do
    #   it test do
    #   end
    # end

    context "#perform_slide" do
      it "should return true on a valid move" do
        p = Piece.new(:r, [2, 1], board)
        expect(p.perform_slide([3, 0])).to eq true
      end

      it "should return false on a invalid move" do
        p = Piece.new(:r, [2, 1], board)
        expect(p.perform_slide([4, 3])).to eq false
      end
    end

      # context "#perform_moves!" do
      #   it "should not raise an error for a valid slide move" do
      #     p = Piece.new(:r, [2, 1], board)
      #     expect {p.perform_moves!([3,0])}.not_to raise_error
      #   end

      #   it "should raise an error for an invalid slide move" do
      #     p = Piece.new(:r, [2, 1], board)
      #     expect {p.perform_moves!([4, 1])}.to raise_error
      #   end

      #   it "should not raise an error for a valid jump move" do
      #     p  = Piece.new(:r, [2, 1], board)
      #     p2 = Piece.new(:b, [5, 4], board)
      #     p.perform_moves!([3,2])
      #     p2.perform_moves!([4,3])
      #     expect {p.perform_moves!([5, 4])}.not_to raise_error
      #   end

      #   it "should raise an error for a invalid jump move" do
      #     p  = Piece.new(:r, [2, 1], board)
      #     p2 = Piece.new(:r, [2, 3], board)
      #     p3 = Piece.new(:r, [5, 2], board)
      #     p2.perform_moves!([3,2])
      #     expect {p3.perform_moves!([4, 7])}.to raise_error
      #     expect {p.perform_moves!([4, 3])}.to raise_error
      #   end
      # end

    context "#perform_jump" do
      it "should return true on a valid move" do
        p  = Piece.new(:r, [2, 1], board)
        p2 = Piece.new(:b, [5, 4], board)
        p.perform_moves!([[3,2]])
        p2.perform_moves!([[4,3]])
        expect(p.perform_jump([5, 4])).to_not eq false
      end

      it "should return false on an invalid move" do
        p  = Piece.new(:r, [2, 1], board)
        p2 = Piece.new(:r, [2, 3], board)
        p3 = Piece.new(:r, [5, 2], board)
        p2.perform_moves!([[3,2]])
        expect(p3.perform_jump([4,7])).to eq false
        expect(p.perform_jump([4,3])).to eq false
      end
    end

    context "#maybe_promote" do
      it "should return true if piece should be promoted" do
        p = Piece.new(:r, [7, 0], board)
        expect(p.maybe_promote).to eq true
      end
      
      it "should modify the value of king" do
        p = Piece.new(:r, [7, 0], board)
        p.maybe_promote
        expect(p.king).to eq true
      end

      # it "should modify the length of moves" do
      #   p = Piece.new(:r, [7, 0], board)
      #   p.maybe_promote
      #   expect(p.moves.count).to eq 4
      # end

      it "should not promote a piece if they are not eligible" do 
        p = Piece.new(:r, [4, 0], board)
        p.maybe_promote
        expect(p.king).to eq false
      end

      it "should allow for the performance of a backwards move" do
        board2 = Board.new
        p8 = Piece.new(:r, [6, 1], board2)
        p8.perform_moves([[7, 0]])
        b8 = Piece.new(:b, [7, 2], board2)
        board2.render
        b8.perform_moves([[6, 1]])
        board2.render
        p8.perform_moves([[5, 2]])
        board2.render
        expect(p8.position).to eq([5, 2])
        expect(board.at_position([6, 1])).to eq(nil)
      end
    end

    # context "#silde_assign" do
    #   it "should reassign both the destination and origin on the board" do
    #     p = Piece.new(:r, [2, 1], board)
    #     p.slide_assign([3, 0])
    #     expect(board.at_position([2, 1])).to eq nil
    #     expect(board.at_position([3, 0])).to eq p
    #     expect(p.position).to eq [3, 0]
    #   end
    # end

    # context "#jump_assign" do
    #   it "should reassign both the destination and origin on the board" do
    #     p  = Piece.new(:r, [2, 1], board)
    #     p2 = Piece.new(:b, [5, 4], board)
    #     p.perform_moves!([[3,2]])
    #     p2.perform_moves!([[4,3]])
    #     p.jump_assign([4, 3], [5, 4])
    #     expect(board.at_position([3, 2])).to eq nil
    #     expect(board.at_position([4, 2])).to eq nil
    #     expect(board.at_position([5, 4])).to eq p
    #     expect(p.position).to eq [5, 4]
    #   end
    # end

    # context "#multiple_moves" do
    #   it "should make a series of jump moves" do
    #     p  = Piece.new(:r, [2, 5], board)
    #     p2 = Piece.new(:r, [1, 6], board)
    #     p3 = Piece.new(:b, [5, 2], board)
    #     p.perform_moves!([[3,4]])
    #     p.perform_moves!([[4,3]])
    #     p2.perform_moves!([[2,5]])
    #     expect {p3.multiple_moves([[3, 4], [1, 6]])}.to_not raise_error
    #   end

    #   it "should not make a series of moves if they are not all jumps" do
    #     p  = Piece.new(:r, [2, 5], board)
    #     p3 = Piece.new(:b, [4, 2], board)
    #     p.perform_moves!([[3,4]])
    #     p.perform_moves!([[4,3]])
    #     expect {p3.multiple_moves([[3, 4], [2, 5]])}.to raise_error
    #   end
    # end

    context "#valid_move_seq?" do
      it "shouldn't modify the original board" do
        p = Piece.new(:r, [2, 5], board)
        p2 = Piece.new(:r, [1, 6], board)
        p3 = Piece.new(:b, [5, 2], board)
        p.perform_moves!([[3,4]])
        p.perform_moves!([[4,3]])
        p2.perform_moves!([[2,5]])
        p3.valid_move_seq?([[3, 4], [1, 6]])
        expect(board.grid).to eq (board.grid)
      end

      it "should return true for a valid move series" do
        p = Piece.new(:r, [2, 5], board)
        p2 = Piece.new(:r, [1, 6], board)
        p3 = Piece.new(:b, [5, 2], board)
        p.perform_moves!([[3,4]])
        p.perform_moves!([[4,3]])
        p2.perform_moves!([[2,5]])
        expect(p3.valid_move_seq?([[3, 4], [1, 6]])).to eq true
      end

      it "should return false for a valid move series" do
        p  = Piece.new(:r, [2, 5], board)
        p3 = Piece.new(:b, [4, 2], board)
        p.perform_moves!([[3,4]])
        p.perform_moves!([[4,3]])
        expect(p3.valid_move_seq?([[3, 4], [2, 5]])).to eq false
      end
    end

  end
end