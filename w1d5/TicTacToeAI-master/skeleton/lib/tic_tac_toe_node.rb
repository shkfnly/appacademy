require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def self.toggle(mark)
    mark == :x ? :o : :x
  end
  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    childs = []
    @board.rows.each_with_index do |row, i|
      row.each_with_index do |column, j|
        pos = [i, j]
        if @board.empty?(pos)
          duped_board = @board.dup
          duped_board.[]=(pos, @next_mover_mark)
          childs << TicTacToeNode.new(duped_board, self.class.toggle(@next_mover_mark), pos)
        end
      end
    end
    childs

  end

  def losing_node?(evaluator)
    if board.over?
      return false if @board.winner.nil? || @board.winner == evaluator
      return true if @board.winner != evaluator
    end
    if evaluator == @next_mover_mark
      children.all? do |node|
          node.losing_node?(evaluator)
        end
    else
      children.any? do |node|
        node.losing_node?(evaluator)
      end
    end
  end

  def winning_node?(evaluator)
    if board.over?
      return true if @board.winner == evaluator
      return false if @board.winner.nil? || @board.winner != evaluator
    end
    if evaluator == @next_mover_mark
      children.any? do |node|
        node.winning_node?(evaluator)
      end
    else
      children.all? do |node|
        node.winning_node?(evaluator)
      end
    end
  end

end
