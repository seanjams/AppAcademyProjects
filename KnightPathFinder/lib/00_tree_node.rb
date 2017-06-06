require 'byebug'

class PolyTreeNode
  attr_reader :value, :parent, :children

  def initialize(value, parent = nil, children = [])
    @value = value
    @parent = parent
    @children = children
  end

  def add_child(*nodes)
    nodes.each do |node|
      unless @children.include?(node)
        @children << node
        node.parent = self
      end
    end
  end

  def remove_child(*nodes)
    nodes.each do |node|
      raise "node is not a child" unless @children.include?(node)
      @children.delete(node)
      node.parent = nil
    end
  end

  def parent=(node)
    @parent.children.delete(self) unless @parent.nil?
    @parent = node
    unless node.nil? || node.children.include?(self)
      node.children << self
    end
  end

  def dfs(target_value)
    return self if @value == target_value
    @children.each do |child|
      result = child.dfs(target_value)
      return result if result
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      cur_node = queue.shift
      if cur_node.value == target_value
        return cur_node
      else
        queue.concat(cur_node.children)
      end
    end
    nil
  end

end

# d = PolyTreeNode.new('d')
# e = PolyTreeNode.new('e')
# f = PolyTreeNode.new('f')
# g = PolyTreeNode.new('g')
# b = PolyTreeNode.new('b')
# c = PolyTreeNode.new('c')
# a = PolyTreeNode.new('a')
# b.add_child(d,e)
# c.add_child(f,g)
# a.add_child(b,c)
# a.dfs("g")
# a.bfs("g")
