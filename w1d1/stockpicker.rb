def stockpicker(arr)
  profit = 0
  pos1, pos2 = 0, 0
  (0...arr.length).each do |i|
    (i + 1...arr.length).each do |j|
      if arr[j] - arr[i] > profit
        profit = arr[j] - arr[i]
        pos1, pos2 = i, j
      end
    end
  end

  [pos1, pos2]
end

stockpicker([1, 2, 3])
