require 'byebug'
require 'io/console'
require_relative "./minesweeper/cell.rb"
require_relative "./minesweeper/board.rb"

module Minesweeper

class NewGame
  def initialize
    @game_state = Board.new
  end

  def play
    puts "Would you like to continue a game? (y/n)"
    continue_game = gets.chomp
    if continue_game == 'y'
      puts "What was the filename?"
      filename = gets.chomp
      file = File.read(filename)
      @game_state = YAML::load(file)
    end

    while true
      @game_state.render
      puts "Would you like to save? (y/n)"
      save_state = gets.chomp

      unless save_state == 'y'
        puts "What position would you like to select (x,y)"
        user_position = gets.chomp.split(",").map(&:to_i)
        puts "Do you want to flag this? (y/n)"
        user_answer = gets.chomp
        if user_answer == 'y'
          @game_state.flag_cell(user_position)
        else
          @game_state.play_move(user_position)
        end
      else
        serialized_game = @game_state.to_yaml
        puts 'Filename?'
        filename = gets.chomp + '.yml'
        File.open(filename, 'w') do |f|
          f.puts serialized_game
        end
        exit
      end

    end
  end
  end
end
#
#
# def take_input
#   get



Minesweeper::NewGame.new.play
