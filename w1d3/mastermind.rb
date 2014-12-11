class Code
  attr_accessor :pegs, :answer, :user_guess

  PEGS = %w(r g b y o p)
  CODE_LENGTH = 4

  def self.random
    answer = []
    Code::CODE_LENGTH.times { answer << Code::PEGS.sample }
    answer
  end

  def initialize
    @answer = self.class.random
  end

  def parse(input)
    input.downcase.split('')
  end

  def compare_with(user_guess)
    return puts "You Win!" if exact_matches(user_guess) == 4
    puts "You had #{exact_matches(user_guess)} exact matches"
    puts "You had #{near_matches(user_guess)} near matches"
  end

  def exact_matches(user_guess)
    exacts = []
    answer.each_with_index do |x, i|
      exacts << x if x == user_guess[i]
    end
    exacts.count
  end

  def near_matches(user_guess)
    result = []
    matches = answer.select { |letter| user_guess.include?(letter) }
    number_of_letters(matches).each do |letter, number|
      result << [number_of_letters(answer)[letter], number].min
    end
    result.reduce(:+)
  end

  def number_of_letters(array)
    instance_of_letters = Hash.new { |hash, key| hash[key] = 0 }
    array.each { |peg| instance_of_letters[peg] += 1 }
    instance_of_letters
  end

end

class Game
  attr_accessor :answer_counter, :user_guess
  attr_reader :code

  def initialize
    @code = Code.new
    @answer_counter = 0
    @user_guess = []
  end

  def play
    p code
    until code.exact_matches(@user_guess) == 4
      turns
      puts answer_counter
    end
  end

  def turns
    puts "What is you guess?"
    input = gets.chomp
    @user_guess = code.parse(input)
    code.compare_with(@user_guess)
    @answer_counter += 1
  end
end

a = Game.new
a.play
