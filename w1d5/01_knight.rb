require './00_tree_node.rb'
require 'byebug'

class KnightPathFinder
  attr_accessor :start, :visited_positions, :move_tree

  BOARD_POSITIONS = []
  (0..7).each { |x| (0..7).each { |y| BOARD_POSITIONS << [x, y] } }

  DIRECTIONS = [[2, -1], [2, 1], [-2, -1], [-2, 1], [-1, 2], [-1, -2], [1, 2], [1, -2]]

  def initialize(start)
    @start = PolyTreeNode.new(start)
    @visited_positions = [@start.value]
    @move_tree = []
    build_move_tree(@start)
  end

  def build_move_tree(node)

    # marker = true
    # while marker
    #   new_moves = new_move_positions(node)
    #   break if new_moves.empty?
    #   # @move_tree << node
    #   # move_tree += new_moves
    #   new_moves.each do |move|
    #     build_move_tree(move)
    #   end
    # end
    # if BOARD_POSITIONS.include?(node.value)
    #   new_move_positions(node).each do |n|
    #     build_move_tree(n)
    #   end
    # end
    queue = [node]
    until queue.empty?
      holder = queue.shift
      new_children = new_move_positions(holder)
      queue += new_children
    end


  end

  def new_move_positions(node)
    new_positions = self.class.valid_moves(node).select do |node|
      !@visited_positions.include?(node.value)
    end
    # debugger
    new_positions.each do |el|
      # el.parent = node
      node.add_child(el)
      @visited_positions << el.value
    end
    new_positions
  end

  def self.valid_moves(node)
    x, y = node.value
    b = []
    DIRECTIONS.each do |x_move, y_move|
      move = [x + x_move, y + y_move]
      b << PolyTreeNode.new(move) if BOARD_POSITIONS.include?(move)
    end
    b
  end

  def find_path(end_pos)
    paths =
    @start.bfs(end_pos).trace_path_back
  end


end

a = KnightPathFinder.new([0, 0])
p a.find_path([7, 6])
