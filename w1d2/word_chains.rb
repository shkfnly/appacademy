require 'set'

class WordChainer
  attr_reader :dictionary
  attr_accessor :new_current_words, :all_seen_words, :current_words

  def initialize(dic_file_name)
    @dictionary = File.read(dic_file_name).split.to_set
    @all_seen_words = Hash.new(nil)
  end

  def adjacent_words(word, letter_position)
    letters = word.chars
    front_half = letters[0..letter_position]
    back_half = letters[(letter_position + 1)...letters.count]
    adj_word = []
      ('a'..'z').each do |letter|
        unless letter == letters[letter_position]
          front_half[letter_position] = letter
          word_test = (front_half + back_half).join
          adj_word << word_test if @dictionary.include?(word_test)
        end
      end
    adj_word
  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words = {source => nil}
    i = 0
    until @current_words.empty? || @current_words.include?(target)
        @new_current_words = []
        explore_current_words(current_words)
        @current_words = new_current_words
    end
    p build_path(target)
  end

  def explore_current_words(list_of_words)
    list_of_words.each do |word|
      (0...word.length).each do |index|
        adjacent_words(word, index).each do |new_word|
          unless @all_seen_words.keys.include? new_word
            new_current_words << new_word
            @all_seen_words[new_word] = word
          end
        end
      end
    end
    new_current_words.each do |word|
      #puts "#{word} came from #{all_seen_words[word]}"
    end       
  end

  def build_path(target)
    path = [target]
    prev_word = @all_seen_words[target]
    until  prev_word.nil?
      path.unshift(prev_word)
      prev_word = @all_seen_words[prev_word]
    end
    path
  end 

end


a = WordChainer.new('dictionary.txt')