class Game

  attr_accessor :guess, :player1, :player2, :incorrect_guesses, :hangman, :word
  attr_reader :word_length

  HANGMANERRORS = Hash[1, ["O", [2, 3]],
                       2, ["|", [3, 3]],
                       3, ["/", [3, 2]],
                       4, [92.chr, [3, 4]],
                       5, ["|", [4, 3]],
                       6, ["/", [5, 2]],
                       7, [92.chr, [5, 4]]]

  def initialize(player1, player2, word)
    @word = word
    @word_length = word.length
    @response = Array.new(@word_length, '_')
    @hangman = ['____  '.split(''),
                '|  |  '.split(''),
                '|     '.split(''),
                '|     '.split(''),
                '|     '.split(''),
                '|     '.split(''),
                '======'.split('')]
    @incorrect_guesses = 0
    @player1 = player1
    @player2 = player2
  end

  def hangman_rendering
    unless @incorrect_guesses == 0
      x, y = Game::HANGMANERRORS[@incorrect_guesses][1]
      @hangman[x][y] = HANGMANERRORS[@incorrect_guesses][0]
    end
    @hangman.each { |row| puts row.join }
  end

  def render
    hangman_rendering
    puts @response.join(" ")
  end

  def play(player)
    # this should be refactored where there is no access to word at this point
    while @incorrect_guesses < 7 && @word != @response
      render
      guess = player.make_guess
      checked_guess = player.check_guess(guess, @word) # return value should be correct indicies
      if checked_guess.nil?
        @incorrect_guesses += 1
      else
        checked_guess.each do |pos|
          @response[pos] = guess
        end
      end
    end
    hangman_rendering
    if @word == @response
      puts "#{player.name} Wins!"
    else
      puts "#{player.name} Loses :("
    end
  end
end

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
  attr_accessor :guesses_made, :name, :words_with_letters, :frequencies, :words, :word, :word_length

  WORDS = File.readlines('./dictionary.txt').map(&:chomp)

  def initialize(word = ComputerPlayer::WORDS.sample.split(''))
    @guesses_made = []
    @name = "Computer"
    @word = word
    @word_length = @word.length
    @words_with_letters = reduce_words_by_length
  end

  def reduce_words_by_length
    all_words = ComputerPlayer::WORDS.select do |word|
      word.length == word_length
    end
    all_words
  end

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

  def check_guess(guess, _word_from_game)
    puts "Computer guesses: #{guess}"
    puts "What are the positions of the letter? Put 'none' if there are no matches."
    p word.join(" ")
    p (0...word.length).to_a.join(" ")
    input = gets.strip

    sanitizer = word.select { |letter| letter == guess }.count
    positions = input.split(' ').map(&:to_i)

    if input == 'none'
      if !word.include?(guess)
        delete_words_by_letter(guess)
        return nil
      else
        check_guess(guess)
      end
    elsif positions.all? { |pos| word[pos] == guess } && positions.count == sanitizer
      select_words_by_position(guess, positions)
      positions
    else
      check_guess(guess)
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "How many people want to play?"
  number_of_people = gets.chomp.to_i
  if number_of_people == 1
    puts "Would you like to 'choose' the word or 'guess' the word?"
    input = gets.chomp
    if input == 'guess'
      puts "What is your name?"
      name = gets.chomp
      player1 = HumanPlayer.new(name)
      player2 = ComputerPlayer.new
      word = player2.word
    else
      puts "What is your name?"
      name = gets.chomp
      puts "Please enter the word."
      word = gets.chomp.split('')
      player1 = ComputerPlayer.new(word)
      player2 = HumanPlayer.new(name)
    end
  elsif number_of_people == 2
    puts "What is Player 1's name?"
    name = gets.chomp
    player1 = HumanPlayer.new(name)
    puts "What is Player 2's name?"
    name = gets.chomp
    player2 = HumanPlayer.new(name)
    puts "Player 1, please enter the word."
    word = gets.chomp.split('')
  elsif number_of_people == 0
    puts "Get ready for awesomeness! Type OK when you are ready."
    input = gets.chomp.split('')
    input = gets.chomp.split('') until input == %w(O K)
    player1 = ComputerPlayer.new
    player2 = ComputerPlayer.new
    word = player2.word
  else
    puts "Please enter 1 or 2"
  end
  a = Game.new(player1, player2, word)
  a.play(player1)
end
