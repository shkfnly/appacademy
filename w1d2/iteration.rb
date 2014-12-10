def factors(num)
  (1...num).each do |factor|
    p factor if num % factor == 0
  end
end

def bubble_sort(arr)
  (0...arr.length).each do |num1|
    (num1...arr.length).each do |num2|
      arr[num1], arr[num2] = arr[num2], arr[num1] if arr[num1] > arr[num2]
    end
  end

  arr
end

# def bubble_sort(arr)
#   sorted = false
#   until sorted
#     sorted = true
#     (0...arr.length).each do |num2|
#       if arr[num1] > arr[num2]
#         arr[num1], arr[num2] = arr[num2], arr[num1]
#         sorted = false
#       end
#     end
#   end
#   arr
# end

def substrings(str)
  result = []
  choices = str.split("")
  (0...choices.length).each do |c|
    (1..str.length).each do |new_word_len|
      if c + new_word_len <= choices.length
        result << choices[c...(c + new_word_len)].join("")
      end
    end
  end
  result
end

# def substrings(str)
#   result = []
#   (0...str.length).each do |index|
#     if str[]

def subwords(str)
  words = File.readlines('dictionary.txt').map(&:chomp)
  substrings(str).select { |word| words.include?(word) }
end

p subwords('cat')
