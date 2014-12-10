def by_2(arr)
  arr.map! { |i| i * 2 }
end

def my_each
  return self unless block.given?
  for i in self
    yield(i)
  end
end

def median(arr)
  arr.sort!
  x = arr.count / 2
  if arr.count.even?
    (arr[x] + arr[x - 1]) / 2.0
  else
    arr[x.floor]
  end
end

puts median([1, 2, 3, 4])
puts median([1, 2, 3])


def inject2(arr)
  arr.inject(:+)
end

puts inject2(["Yay ", "for ", "strings!"])
