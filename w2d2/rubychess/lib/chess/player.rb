require 'byebug'

module Chess

  class HumanPlayer
    attr_reader :name, :symbol_color, :icon

    def initialize(name, symbol_color)
      @name = name
      @symbol_color = symbol_color
      @icon = (symbol_color == :W ?  "  ".colorize(:background => :white) : "  ".colorize(:background => :grey))
    end
  end

  class ComputerPlayer
    attr_reader :name, :symbol_color, :board, :icon

    def initialize(name = "Computron-#{(1..10000).to_a.sample}", symbol_color, board)
      @name = name
      @symbol_color = symbol_color
      @icon = (symbol_color == :W ?  "  ".colorize(:white) : "  ".colorize(:grey))
      @board = board
    end

    def filter_moves(piece_moves) # takes piece => moves hash and returns random move
      filtered_moves = piece_moves.select { |piece, moves| moves.count > 0 }
      chosen_piece = filtered_moves.keys.sample
      chosen_move = filtered_moves[chosen_piece].sample

      [chosen_piece, chosen_move]
    end

    def smart_moves
      board.render(self)
      attack_moves = Hash.new { |h, k| h[k] = [] }
      defensive_moves = Hash.new { |h, k| h[k] = [] }
      all_moves = Hash.new {|h, k| h[k] = []}
      board.current_pieces[symbol_color].each do |piece|
        all_moves[piece] += piece.valid_moves(piece.moves)
      end

      all_moves.each do |piece, moves|
        moves.each do |move|
          attack_moves[piece] << move if board.takes_piece?(piece, move)
          defensive_moves[piece] << move if board.avoids_attack?(piece, move, symbol_color)
        end
      end

      if attack_moves.any?
        chosen_piece, chosen_move = filter_moves(attack_moves)
      elsif defensive_moves.any?
        chosen_piece, chosen_move = filter_moves(defensive_moves)
      else
        chosen_piece, chosen_move = filter_moves(all_moves)
      end

      board.move(chosen_piece.position, chosen_move)
    end
  end
end
