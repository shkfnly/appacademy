module Checkers
  
  class Game

    attr_accessor :game_board

    def initialize
      @game_board = Board.new
      @game_board.create_initial_board
    end 

    def start
      puts "Welcome To Checkers!"
      begin
        puts "How many players? (1 or 2)"
        response = gets.chomp
        if response == '1'

        elsif response == '2'
          puts "What's player 1's name?"
          name1 = gets.chomp
          player1 = Checkers::Player.new(name1, :r)
          puts "What's player 2's name?"
          name2 = gets.chomp
          player2 = Checkers::Player.new(name2, :b)
          system("clear")
          @game_board.render
          play(player1, player2)
        else
          raise InvalidNumberofPlayers
        end
      rescue InvalidNumberofPlayers
        puts "Please enter a valid number of players"
        retry
      end
    end

    def play(player1, player2)
      curr = player1
      until @game_board.pieces[:r] == 0 || @game_board.pieces[:b] == 0
        puts "#{curr.name}'s Turn."
        begin
          puts "What piece would you like to move (x, y)"
          moving_piece = gets.chomp.split(',').map(&:to_i)
          moves = []
          another_move = "y"
          until another_move == 'n'
            puts "What move would you like to make (x, y)"
            moves << gets.chomp.split(',').map(&:to_i)
            puts "Would you like to make another move? (y, n)"
            another_move = gets.chomp
          end
          game_board.at_position(moving_piece).perform_moves(moves)
        rescue
          system('clear')
          puts "Please select valid moves!"
          @game_board.render
          retry
        end
        system('clear')
        @game_board.render
        curr == player1 ? curr = player2 : curr = player1
      end
      winner(player1, player2)
    end

    def switch_players(curr, player1, player2)
      curr == player1 ? curr = player2 : curr == player1
    end

    def winner(player1, player2)
      if @game_board.piece[:r] == 0
        puts "Black Wins!"
        puts "Congratulations #{player2.name}"
      else
        puts "Red Wins!"
        puts "Congratulations #{player1.name}"
      end
    end


  end
end