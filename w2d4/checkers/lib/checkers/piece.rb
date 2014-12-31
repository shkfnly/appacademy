#!/usr/env/ruby

require 'colorize'
require 'byebug'
module Checkers

  class Piece

    MOVES =     { b: [[-1,  1],
                      [-1, -1]],
                  r: [[ 1,  1],
                      [ 1, -1]]}

    attr_accessor :position, :king, :moves
    attr_reader   :board, :color, :position, :icon

    # Red is coming down, Black is coming up
    def initialize(color, position, board, king = false)
      @color, @position, @board, @king = color, position, board, king
      board.set_position(position, self)

      @icon = color == :r ? 'R' : 'B'
      @moves = MOVES[@color]
      
    end

    def dup_piece(new_board)
      Piece.new(color, position, new_board, king)
    end

    def king?
      @king
    end

    def perform_moves(move_seq)#takes an array of moves
      if valid_move_seq?(move_seq)
        perform_moves!(move_seq)
      else
        raise InvalidMoveError
      end
    end

    #RENDER

    def valid_move_seq?(move_seq)
      duped_board = board.dup_board
      duped_piece = dup_piece(duped_board)
      duped_move_seq = move_seq.dup
      begin
        duped_piece.perform_moves!(duped_move_seq)
      rescue
        false
      else
        true
      end
    end

    def at_back_row?
      case color
      when :r
        position[0] == 7
      when :black
        position[0] == 0
      end
    end

    def maybe_promote
      @king = true if at_back_row?
    end

    def move_diffs(pos = position)
      # x, y = pos
      # moves.map do |x2, y2|
      #   [x + x2, y + y2]
      # end
      if king?
        MOVES[:r] + MOVES[:b]
      else
        MOVES[color]
      end
    end

    def perform_slide(dest)
      return false unless Board.valid_pos?(dest)
      return false unless board.at_position(dest).nil?

      move_diff = [
        dest[0] - self.position[0],
        dest[1] - self.position[1]
      ]

      return false unless move_diffs.include?(move_diff)

      board.set_position(position, nil)
      self.position = dest
      board.set_position(dest, self)
      maybe_promote
      true

      # if board.at_position(dest).nil?
      #   move_diffs(position).each do |pos|
      #     if pos == dest
      #       return true
      #     end
      #   end
      # end
      # false
    end

    def perform_jump(dest)
      return false unless Board.valid_pos?(dest)
      jump_diff = [
        (dest[0] - position[0]).fdiv(2),
        (dest[1] - position[1]).fdiv(2)
      ]

      return false unless move_diffs.include?(jump_diff)
      jumped_pos = [
        position[0] + jump_diff[0],
        position[1] + jump_diff[1]
      ]
      if board.at_position(jumped_pos).nil? || board.at_position(jumped_pos).color == color
        return false
      end
      board.set_position(position, nil)
      board.set_position(jumped_pos, nil)
      self.position = dest
      board.set_position(dest, self)
      maybe_promote
      true
      # # Check each space one move away from the current position
      # move_diffs(position).each do |pos|
      #   # Return the value or object at those positions
      #   test_loc = board.at_position(pos)
      #   # If that position is nil or a piece of the same color go no further
      #   unless test_loc.nil?  || test_loc.color == color
      #     # Select the moves one away from this position
      #     move_diffs(pos).each do |jump_pos|
      #       #if this new position is == to the destination
      #       jump_loc = board.at_position(jump_pos)
      #       if jump_pos == dest && jump_loc.nil?
      #         return pos
      #       end
      #     end
      #   end
      # end
      # false
    end
    

    

    # def one_move(move)
    #   if perform_slide(move)
    #     slide_assign(move)
    #   elsif perform_jump(move)
    #     jump_assign(perform_jump(move), move)
    #   else
    #     raise InvalidMoveError
    #   end
    # end

    # def multiple_moves(move_seq)
    #   until move_seq.empty?
    #     move = move_seq.shift
    #     unless perform_slide(move) || !perform_jump(move)
    #       stor_pos = perform_jump(move)
    #       jump_assign(stor_pos, move)
    #     else
    #       raise InvalidMoveError
    #     end
    #   end
    # end

    # def slide_assign(dest)
    #   board.set_position(position, nil)
    #   board.set_position(dest, self)
    #   @position = dest
    # end

    # def jump_assign(pos, dest)
    #   board.set_position(pos, nil)
    #   board.remove_piece(color)
    #   slide_assign(dest)
    # end

    def perform_moves!(move_seq)
      if move_seq.count == 1
        pos = move_seq.first
        unless perform_slide(pos) || perform_jump(pos)
          raise InvalidMoveError
        end
      else
        move_seq.each do |move_pos|
          raise InvalidMoveError unless perform_jump(move_pos)
        end
      end
      # raise ArgumentError if move_seq.empty? || move_seq.nil?
      # if move_seq.count == 1
      #   move = move_seq.pop
      #   one_move(move)
      # else
      #   multiple_moves(move_seq)
      # end
    end

    # No Test but Assumed Working



    private

    # No Test but Assumed Working


  end
end

if  __FILE__ == $PROGRAM_NAME
  puts 'test'
end