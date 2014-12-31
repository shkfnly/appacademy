# -*- coding: utf-8 -*-

require 'colored'

class IllegalMoveError < RuntimeError
end

class Piece
  attr_reader :board, :color, :pos

  def initialize(color, board, pos, king = false)
    @color, @board, @pos, @king = color, board, pos, king

    board[pos] = self
  end

  def dup(new_board)
    Piece.new(color, new_board, pos, king?)
  end

  def king?
    @king
  end

  def perform_moves(move_positions)
    if valid_move_seq?(move_positions)
      perform_moves!(move_positions)
    else
      raise IllegalMoveError
    end
  end

  def render
    char = (king?) ? "♔" : "♙"
    (color == :red) ? char.red : char.black
  end

  def valid_move_seq?(move_positions)
    duped_board = board.dup
    begin
      duped_board[pos].perform_moves!(move_positions)
    rescue IllegalMoveError
      false
    else
      true
    end
  end

  protected
  attr_writer :pos

  RED_MOVES = [
    [ 1, -1],
    [ 1,  1]
  ]

  BLACK_MOVES = [
    [-1, -1],
    [-1,  1]
  ]

  def at_back_row?
    case color
    when :red
      pos[0] == 7
    when :black
      pos[0] == 0
    end
  end

  def maybe_promote
    @king = true if at_back_row?
  end

  def move_diffs
    if king?
      RED_MOVES + BLACK_MOVES
    else
      (color == :red) ? RED_MOVES : BLACK_MOVES
    end
  end

  def perform_jump(move_pos)
    return false unless Board.valid_pos?(move_pos)

    jump_diff = [
      (move_pos[0] - pos[0]).fdiv(2),
      (move_pos[1] - pos[1]).fdiv(2)
    ]

    return false unless move_diffs.include?(jump_diff)
    jumped_pos = [
      pos[0] + jump_diff[0],
      pos[1] + jump_diff[1]
    ]

    if board.empty?(jumped_pos) || board[jumped_pos].color == color
      return false
    end

    board[pos] = nil
    board[jumped_pos] = nil
    self.pos = move_pos
    board[move_pos] = self

    maybe_promote

    true
  end

  # this one isn't reversible if it fails!
  def perform_moves!(move_positions)
    if move_positions.count == 1
      pos = move_positions.first
      unless perform_slide(pos) || perform_jump(pos)
        raise IllegalMoveError
      end
    else
      move_positions.each do |move_pos|
        raise IllegalMoveError unless perform_jump(move_pos)
      end
    end
  end

  def perform_slide(move_pos)
    return false unless Board.valid_pos?(move_pos)
    return false unless board.empty?(move_pos)

    move_diff = [
      move_pos[0] - self.pos[0],
      move_pos[1] - self.pos[1]
    ]

    return false unless move_diffs.include?(move_diff)

    board[pos] = nil
    self.pos = move_pos
    board[move_pos] = self

    maybe_promote

    true
  end
end
