class GuessGame
  attr_accessor :guess, :guess_count

  def initialize
    @guess_count = 0
    @answer = answer_setter
  end

  def get_guess
    loop do
      puts "What is your guess?"
      guess = gets.chomp.to_i
      if guess > @answer
        puts 'Too High'
      elsif guess < @answer
        puts 'Too Low'
      else
        puts "You got it right"
        puts "#{@guess_count}"
        break
      end
      @guess_count += 1
      puts "#{@guess_count}"
    end
  end

  private

  def answer_setter
    Random.rand(1..101)
  end
end
