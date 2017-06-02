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
    @parent = node unless @parent
    node.children << self unless node.nil?
  end

  def add_child(node)
    @children << node
  end

  def remove_child
  end



end
