require_relative "00_tree_node.rb"

class KnightPathFinder
  DELTAS = [[1, 2], [2, 1], [-1, 2], [2, -1],
            [1, -2], [-2, 1], [-1, -2], [-2, -1]]

  def initialize(start_pos = [])
    @start_pos = start_pos
    @board = Array

  end

  def in_range?(node)
    # x, y = pos
    node.value.all? {|el| (0..7).include?(el)}
  end

  def neighbors(pos)
    result = []
    x, y = pos
    DELTAS.each do |delta|
      result << PolyTreeNode.new([delta[0] + x, delta[1] + y])
    end
    result.select { |neighbor| in_range?(neighbor) }
  end

  def find_path(pos)
  end

  def build_move_tree
    root = PolyTreeNode.new(@start_pos)
    family = []
    debugger
    until family.length == 64
      neighbors(root.value).each do |node|
        root.add_child(node) unless family.include?(node)
      end
      family += root.children
    end

     p family
  end

  def new_move_positions
  end

  def find_path(end_pos)
  end

  def trace_path_back
  end

end

kpf = KnightPathFinder.new([0, 0])
# debugger
kpf.build_move_tree.each { |node| puts node.value }
# kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
# kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]
