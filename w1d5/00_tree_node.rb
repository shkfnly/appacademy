class PolyTreeNode
  attr_accessor :value, :children
  attr_reader :parent

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

# WHATTTTTTTTTTTTTTTT

  def parent=(par)
    # using @parent due to overriding setter method. Need to refer to instance variable to change
    return @parent = nil if par.nil?
    unless parent == par
      unless parent.nil?
        parent.children.delete(self)
      end
      @parent = par
      par.children.push(self)
    end
  end

  def add_child(child)
    child.parent = self

    self.children << child unless self.children.include?(child)
  end

  def remove_child(child)
    raise "Not a child" unless self.children.include?(child)
    child.parent = nil #Don't want to change child's parent unless self is the parent
    self.children.delete(child)
  end

  def dfs(val)
    return self if self.value == val
    self.children.each do |child|
      result = child.dfs(val)
      return result unless result.nil?
    end
    nil
  end

  def bfs(val)
    queue = []
    queue << self
    until queue.empty?
      holder = queue.shift
      if holder.value == val
        return holder
      else
        holder.children.each do |child|
          queue << child
        end
      end
    end
    nil
  end

  def trace_path_back
    return [self.value] if self.parent.nil?
    self.parent.trace_path_back + [self.value]
  end

end

# parent => reader
# self.parent = ??? => writer
