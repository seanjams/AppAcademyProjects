require 'byebug'

class PolyTreeNode

  def initialize(value, parent = nil, children = [])
    @value = value
    @parent = parent
    @children = children
  end

  attr_reader :parent, :children, :value
  # def parent
  # end
  #
  # def children
  # end
  #
  # def value
  # end

  def parent=(node)
    #debugger
    @parent.children.delete(self) unless @parent.nil?
    @parent = node
    node.children << self unless node.nil? || node.children.include?(self)

  end

  def add_child(*nodes)
    #debugger
    nodes.each do |node|
      node.parent = self
      @children << node unless @children.include?(node)
    end
  end

  def remove_child(*nodes)
    nodes.each do |node|
      node.parent = nil
      raise "node is not a child" unless self.children.include?(node)
      self.children.delete(node)
    end
  end

  def dfs(target_value)
    # p self.value
    return self if self.value == target_value
    #inductive step
    self.children.each do |child|
      result = child.dfs(target_value)
      return result if result
    end
    nil
  end

  def bfs(target_value)
    # debugger

    queue = [self]
    # return self.value if target_value == self.value
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
