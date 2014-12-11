class Game

  attr_accessor :word, :words, :word_length, :guess, :player, :incorrect_guesses, :hangman

  def initialize
    @words = File.readlines('./dictionary.txt').map(&:chomp)
    @word = @words.sample.split('')
    @word_length = @word.length
    @response = Array.new(@word_length, '_')
    @hangman = ['____  '.split(''),
                '|  |  '.split(''),
                '|     '.split(''),
                '|     '.split(''),
                '|     '.split(''),
                '|     '.split(''),
                '======'.split('')]
    @incorrect_guesses = 0
    @hangman_errors = Hash[1, ["O", [2, 3]],
                           2, ["|", [3, 3]],
                           3, ["/", [3, 2]],
                           4, [92.chr, [3, 4]],
                           5, ["|", [4, 3]],
                           6, ["/", [5, 2]],
                           7, [92.chr, [5, 4]]]
  end

  def hangman_rendering
    unless @incorrect_guesses == 0
      x, y = @hangman_errors[@incorrect_guesses][1]
      @hangman[x][y] = @hangman_errors[@incorrect_guesses][0]
    end
    @hangman.each { |row| puts row.join }
  end

  def render
    hangman_rendering
    puts @response.join(" ")
  end

  def start
    puts "Would you like to 'choose' the word or 'guess' the word?"
    input = gets.chomp
    if input == 'guess'
      puts "What is your name?"
      name = gets.chomp
      @player = HumanPlayer.new(name)
      play(@player)
    else
      puts "Please enter the word."
      @word = gets.chomp.split('')
      @words << @word
      @word_length = @word.length
      @player = ComputerPlayer.new(self)
      @response = Array.new(@word_length, '_')
      play(@player)
    end
  end

  def play(player)
    while @incorrect_guesses < 7 && @word != @response
      render
      guess = player.make_guess
      checked_guess = check_guess(player, guess)
      if checked_guess.nil?
        @incorrect_guesses += 1
      else
        checked_guess.each do |pos|
          @response[pos] = guess
        end
      end
    end
    hangman_rendering
    @word == @response ? "#{player.name} Wins!" : "#{player.name} Loses :("

  end

  def check_guess(player, guess)
    player.check_guess(guess, @word)
  end

end


# class Players
#
#   def make_guess
#   end
#
#   def check_guess
#   end
#
# end


class HumanPlayer
  attr_accessor :name

  def initialize(name)
    @name = name.capitalize
    @guesses_made = []
  end

  def make_guess
    puts "You have guessed #{@guesses_made.join(', ')}"
    puts "What is your guess?"
    input = gets.chomp
    @guesses_made << input
    input
  end

  def check_guess(guess, word)
    return nil unless word.include?(guess)
    position = []
    word.each_with_index do |letter, i|
      position << i if letter == guess
    end
    position
  end






end

class ComputerPlayer
  attr_accessor :guesses_made, :name, :words_with_letters, :frequencies, :game

  def initialize(game)
    @guesses_made = []
    @name = "Computer"
    @game = game
    @words_with_letters = reduce_words_by_length
  end

  def reduce_words_by_length
    game.words.select do |word|
      word.length == game.word_length
    end
  end

  # def select_words_by_letter(letter)
  #   @words_with_letters.select! { |word| word.include? letter }
  # end

  def delete_words_by_letter(letter)
    @words_with_letters.select! { |word| !word.include? letter }
  end

  def select_words_by_position(letter, position)
    @words_with_letters.select! do |word|
      position.all? { |pos| word[pos] == letter }
    end
  end

  def frequency_hash
    @frequencies = Hash.new(0)
    ('a'..'z').each do |letter|
      @words_with_letters.each do |word|
        @frequencies[letter] += 1 if word.include? letter
      end
    end
    @frequencies.sort_by(&:last)
  end

  def make_guess
    frequencies = frequency_hash
    guess = frequencies.pop.first
    guess = frequencies.pop.first while @guesses_made.include?(guess)
    @guesses_made << guess
    guess
  end

  def check_guess(guess, word)
    puts "Computer guesses: #{guess}"
    puts "What are the positions of the letter? Put 'none' if there are no matches."
    p word.join(" ")
    p (0...word.length).to_a.join(" ")
    input = gets.strip
    if input == 'none'
      delete_words_by_letter(guess)
      return nil
    end
    sanitizer = word.select {|x| x == guess}.count
    positions = input.split(' ').map(&:to_i)
    check_guess(guess, word) unless positions.all? { |pos| word[pos] == guess } && positions.count == sanitizer
    select_words_by_position(guess, positions)
    positions
  end
end
