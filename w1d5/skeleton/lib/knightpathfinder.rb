require_relative "00_tree_node.rb"

class KnightPathFinder
  DELTAS = [[1, 2], [2, 1], [-1, 2], [2, -1],
            [1, -2], [-2, 1], [-1, -2], [-2, -1]]

  def initialize(start_pos = [])
    @start_pos = start_pos
    @visited_moves = [@start_pos]
    @move_tree = build_move_tree
  end

  def in_range?(pos)
    # x, y = pos
    pos.all? {|el| (0..7).include?(el)}
  end

  def neighbors(pos)
    result = []
    x, y = pos
    DELTAS.each do |delta|
      result << [delta[0] + x, delta[1] + y]
    end
    result.select { |neighbor| in_range?(neighbor) }
  end

  def find_path(end_pos)

  end

  def trace_path_back
    
  end

  def build_move_tree
    root = PolyTreeNode.new(@start_pos)
    queue = [root]
    until @visited_moves.length == 64
      cur_node = queue.shift
      new_move_positions(cur_node.value).each do |pos|
        cur_node.add_child(PolyTreeNode.new(pos))
      end
      queue += cur_node.children
    end
    root
  end

  def new_move_positions(pos)
    new_moves = neighbors(pos).reject do |xy|
      @visited_moves.include?(xy)
    end
    @visited_moves += new_moves
    new_moves
  end


end

# debugger

# kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
# kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]
