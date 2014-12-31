require 'byebug'
require 'yaml'
require 'io/console'
require 'colorize'

module Chess

  class Game
    attr_reader :game_board

    def initialize
      @game_board = Chess::Board.new
      game_board.generate_start_board
    end

    def start(arr_of_players)
      white_player, black_player = arr_of_players
      current_player = white_player
      until game_board.checkmate?(:W) || game_board.checkmate?(:B)
        current_player == white_player ? (puts "White's move") : (puts "Black's move")
        if current_player.is_a? ComputerPlayer
          begin
            current_player.smart_moves
          rescue
            retry
          end
        else
          begin
            play_move(game_board, current_player)
          rescue
            system("clear")
            puts "Not your piece"
            retry
          end
        end
        system("clear")
        current_player == white_player ? (current_player = black_player) : (current_player = white_player)
      end
      game_board.render(current_player)
      game_board.checkmate?(:W) ? (puts "#{black_player.name.capitalize} Wins") : (puts "#{white_player.name.capitalize} Wins")
    end

    def kb_user_input(current_pos = [0,0], board, player)
      system('clear')
      board.render_cursor(current_pos, player)
      input = STDIN.getch

      unless input == "\r"
        system('clear')
        case input
        when 'w'
          current_pos[0] -= 1 if current_pos[0].between?(1,7)
        when 'a'
          current_pos[1] -= 1 if current_pos[1].between?(1,7)
        when 's'
          current_pos[0] += 1 if current_pos[0].between?(0,6)
        when 'd'
          current_pos[1] += 1 if current_pos[1].between?(0,6)
        end

        kb_user_input(current_pos, board, player)
      end

      system('clear')
      current_pos
    end


    def prompt_player # returns array of players
      puts "Would you like to (l)oad or play a (n)ew game?"
      game_state = gets.chomp
      if game_state == 'n'
        puts "What's your name?"
        name1 = gets.chomp
        puts "Do you want play vs a (h)uman or a (c)omputer"
        response = gets.chomp
        if response == 'h'
          player1 = HumanPlayer.new(name1, :W)
          puts "What is the other player's name?"
          name2 = gets.chomp
          player2 = HumanPlayer.new(name2, :B)
        else
          puts "Do you want to play as (w)hite or (b)lack?"
          color_choice = gets.chomp
          color_choice == 'w' ? player1 = HumanPlayer.new(name1, :W) : player2 = HumanPlayer.new(name1, :B)
          player1.is_a?(HumanPlayer) ? player2 = ComputerPlayer.new(:B, game_board) : player1 = ComputerPlayer.new(:W, game_board)
        end
      end

      [player1, player2]
    end



    def play_move(board, player)
      begin
        origin = self.kb_user_input(board, player)
        dest = self.kb_user_input(origin.dup, board, player)
        if board.piece_on_tile(origin).color != player.symbol_color
          raise "Not player's Piece"
        end
        board.move(origin, dest)
      rescue ArgumentError
        system("clear")
        puts "Not a valid move"
        board.render(player)
        retry
      end
    end

  end
end
