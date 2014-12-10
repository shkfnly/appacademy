class Array
  def my_uniq
    result = []
    self.each do |x|
      result << x unless result.include?(x)
    end
    result
  end
end

puts [1, 2, 1, 3, 3].uniq
