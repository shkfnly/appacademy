class MyHashSet
  include Enumerable

  def initialize
    @store = Hash.new(false)
  end

  def insert(el)
    @store[el] = true
  end

  def include?(el)
    @store[el]
  end

  def delete(el)
    if include?(el)
      @store.delete(el)
      return true
    end
    false
  end

  def to_a
    result = []
    @store.each do |k, v|
      result << [k, v]
    end
    result
  end

  def union(set)
    result = {}
    @store.to_a.each do |k, v|
      result[k] = v
    end
    set.to_a.each do |k, v|
      result[k] = v
    end
    result
  end

  def intersect(set)
    result = {}
    set.to_a.each do |k, v|
      result[k] = v if self.include?(k)
    end
    result
  end
end

hashy = MyHashSet.new
hashy.insert("7")
hashy.insert("8")
hash2 = MyHashSet.new
hash2.insert("7")
hash2.insert("9")
puts hashy.intersect(hash2)
puts hashy.union(hash2)
