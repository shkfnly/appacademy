def range_recur(start, ending)
  return [] if start == ending - 1
  [start + 1] + range_recur(start + 1, ending)
end

def range_iter(start, ending)
  (start+1).upto(ending).to_a
end


def sum_arr_recur(arr)
  return arr if arr.count == 1
  arr.pop + sum_arr_recur(arr)
end


def exp(base, pow)
  return 1 if pow == 0
  base * exp(base, pow - 1)
end


def exp2(base, pow)
  return 1 if pow == 0
  pow.even? ? exp2(exp2(b, pow / 2), 2) : b * exp2(exp2(b, (pow - 1) / 2), 2)
end

def deep_dup(input)
  return input unless input.is_a? Array
  input.each {|i| deep_dup(i)}
end


def fibonacci(n)
  return 0 if n == 1
  return 1 if n == 2
  result = fibonacci(n - 2) + fibonacci(n - 1)
  p result
end

def fib(n)
  return [0, 1].take(n) if n <= 2
  fibs = fib(n - 1)
  fibs << fibs[-1] + fibs[-2]
end

def bsearch(array, value)
  return 'Array not sorted' if array != array.sort
  return nil if array.count < 1 && array.first != value

  midpoint = array.count/2

  if value < array[midpoint]
    array = array[0...midpoint]
    return bsearch(array, value)

  elsif value > array[midpoint]
    array = array[midpoint..-1]
    return midpoint + bsearch(array, value)

  else
    return midpoint
  end

end

COINS = [50, 25, 10, 5, 1]

def get_change(value,coins)
  lengths = []
  coins.each_with_index do |item, i|
    lengths <<  make_change(value, coins[i..-1])
  end
  (0...lengths.count - 1).each do |i|
    lengths[i], lengths[i + 1] = lengths[i + 1], lengths[i] if lengths[i].count > lengths[i+1].count
  end
  lengths.first
end

def make_change(value, coins)
  return [] if value < 1
  if value < coins.first
    coins.shift
    make_change(value, coins)
  else
    remain = value - coins.first
    answer = [coins.first]
    answer + make_change(remain, coins)
  end
end

def merge_sort(array)
  return array if array.count <= 1

  middle = array.count / 2
  left, right = array[0...middle], array[middle..-1]

  left = merge_sort(left)
  right = merge_sort(right)

  merge(left, right)
end

def merge(arr1, arr2)
  result = []
  until arr1.empty? || arr2.empty?
    left, right = arr1.first, arr2.first
    if left > right
      result << arr2.shift
    else
      result << arr1.shift
    end
  end
  arr1.empty? ? result + arr2 : result + arr1
end


def subsets(arr)
  return [] if arr.empty?
  ass1, ass2 = [arr.first], subsets(arr)
  answer = ass2, ass1
end


p subsets([])
p subsets([1])
p subsets([1, 2])
p subsets([1, 2, 3])
