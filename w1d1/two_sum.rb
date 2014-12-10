class Array
  def two_sum
    result = []
    for i in 0...self.length
      for j in i+1...self.length
        if self[i] + self[j] == 0
          result.push([i, j])
        end
      end
    end
    result
  end
end

puts [-1, 0, 2, -2, 1].two_sum
