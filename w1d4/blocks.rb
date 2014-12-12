class Array

  def my_each
    return self unless block_given?
    for i in self
      yield(i)
    end
  end

  def my_map
    results = []
    my_each {|i| results << yield(i)}
    results
  end

  def my_select
    results = []
    my_each {|i| results << i if yield(i)}
    results
  end

  def my_inject(param = self.shift)
    my_each { |i| param = yield(param, i) }
    param
  end


  def my_sort!
    flag  = true
    while flag
      flag = false
      (0...self.count - 1).each do |i|
        if yield(self[i], self[i + 1]) == 1
          self[i], self[i + 1] = self[i + 1], self[i]
          flag = true
        end
      end
    end
    self
  end




end

def eval_block(*args)
  return "NO BLOCK GIVEN" unless block_given?
  yield(*args)
end
