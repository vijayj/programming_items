require_relative 'tree_print'
class Tree

  attr_reader :root


  def insert(data)
    if root == nil
      @root = TreeNode.new(data)
    else
      @root.insertNode(data)
    end
  end

  def find(data)
    if root == nil
      return nil
    else
      node = root.findNode(data)
      node == -1 ? "not found" : p_node(node)
    end
  end

  def delete(data)
    return -1 if root == nil || root.findNode(data) == -1
    x = root.deleteNode(data)
    p "tree delete #{x}"
  end

  def p_node(node)
     " #{node.data} #{node.parent ? node.parent.data : 'root'} #{node.size}\n"
  end

  def randomNode()
    return nil if root.nil?
    index_of_node = rand(@root.size)
    node = root.find_nth_node(index_of_node)
    "random number #{index_of_node} #{node.data} \n"
  end

  def find_common_ancestor(a, b)
    return "" if root.nil?
    result = Result.new()
    node = root.find_common_ancestor(a, b, result)
    p node.data
    if result.found == :both
      p_node node
    end
  end
end

# module Foo
#   BAR = 1
#   BAZ = 2
#   BIZ = 4
# end

# flags = Foo::BAR | Foo::BAZ # flags = 3

Result = Struct.new(:found)


class TreeNode
  attr_accessor :data, :size,:left, :right, :parent

  def initialize(data, parent = nil, size = 1, left = nil, right = nil)
    @data = data
    @parent = parent
    @size = size
    @left = left
    @right = right
  end

  def findNode(data)
    return self if self.data == data

    if data < self.data
      return self.left.findNode(data)  if left_node_exists?(self)
    elsif data > self.data
      return self.right.findNode(data) if right_node_exists?(self)
    end

    return -1
  end

  def insertNode(data)
    if data <= self.data
      if left_node_exists?(self)
        self.left.insertNode(data)
      else
        self.left = TreeNode.new(data, self)
      end
    else data > self.data
      if right_node_exists?(self)
        self.right.insertNode(data)
      else
        self.right = TreeNode.new(data, self)
      end
    end

    self.size += 1
  end

  def left_node_exists?(node) ; node.left != nil ; end
  def right_node_exists?(node) ; node.right != nil ; end

  def find_nth_node(n)
    left_size = left_node_exists?(self) ? self.left.size() : 0
    if n < left_size
      return self.left.find_nth_node(n)
    elsif n == left_size
      return self
    else
      return self.right.find_nth_node(n - (left_size+1))
    end
  end

  def is_leaf?
    left == nil && right == nil
  end

  def find_common_ancestor(a, b, result)
    if self.data == a || self.data == b
       return self
    end

    if left_node_exists?(self)
      left_result = self.left.find_common_ancestor(a,b,result)
      return left_result if result.found == :both
    end

    if right_node_exists?(self)
      right_result = self.right.find_common_ancestor(a,b,result)
      return right_result if result.found == :both
    end

    p "current node is #{self.data}..match left #{left_result}..match right #{right_result}"

    if left_result && right_result
      result.found = :both
      return self
    elsif (self.data == a || self.data == b)
      if (left_result || right_result)
        result.found = :both
        return self
      end
    else
      left_result || right_result
    end

  end

  def deleteNode(data)
    if data < self.data
      if self.left
        result = self.left.deleteNode(data)
        p "#{result}..for node #{self.data}"
        if result
          p "decreasing size for node #{self.data}"
          self.size -= 1
          result
        end
      else
        return false
      end
    elsif data > self.data
      if self.right
        result = self.right.deleteNode(data)
        p "#{result}..for r node #{self.data}"
        if result
          p "decreasing size for r node #{self.data}"
          self.size -= 1
          result
        end
      else
        return false
      end
    else self.data == data
      #4 cases
      if self.is_leaf?
        replace_node(:none,self)
      elsif left_node_exists?(self) && !right_node_exists?(self)
        replace_node(:left,self)
      elsif !left_node_exists?(self) && right_node_exists?(self)
        replace_node(:right,self)
        # self.parent.left = self.left
      else
        #4th case - both child
        successor = self.right.find_min
        p "sucessor is #{successor.data}"
        self.data = successor.data
        p "rs sucessor is #{successor.data}"
        result = self.right.deleteNode(successor.data)
      end

      self.size -= 1
      true
    end
  end

  def find_min
    min = self
    if self.left
      min = self.left.find_min
    end
    return min
  end

  def replace_node(child_position, node)
    if self.parent
      left_child = (parent.left == node)
      case child_position
      when :none
        left_child ? parent.left = nil : parent.right = nil
      when :left
        left_child ? parent.left = node.left : parent.right = node.left
      when :right
        left_child ? parent.right = node.right : parent.right = node.right
      end
    end

    unless child_position == :none
      if child_position == :left
        node.left.parent = parent
      elsif child_position == :right
        node.right.parent = parent
      end
    end
  end
end


t  = Tree.new()
[11, 21, 15, 12, 1, 2, 14, 10,18, 7, 4].each {|x| t.insert(x) }
puts t.to_s

[{1=> 111},{15=> 14}, {1=> 4}].each do |pair|
  a = pair.keys.first
  b = pair.values.first
  p "find common ancestor #{a} #{b}"
  puts t.find_common_ancestor(a, b)
end

p "DELETION CASES..initial state"
puts t.to_s

[14,15,2,10,11].each do |node|
  p "delete #{node}"
  p t.delete(node)
  puts t.to_s
  gets
end

# 0.upto(10) do |x|
#   puts t.randomNode()
# end


# [101,1,14,15,5,11].each do |x|
#   p "finding #{x}"
#   puts t.find(x)
# end
