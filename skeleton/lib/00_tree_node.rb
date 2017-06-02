require 'byebug'

class PolyTreeNode

  def initialize(value, children = [], parent = nil)
    @value = value
    @children = children
    @parent = parent
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

  def add_child(node)
    #debugger
    node.parent = self
    @children << node unless @children.include?(node)

  end

  def remove_child(node)

    node.parent = nil
    raise "node is not a child" unless self.children.include?(node)
    self.children.delete(node)
  end



end
