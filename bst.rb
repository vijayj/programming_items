

class Tree
  attr_accessor :data, :left,:right, :parent

  def self.makeTree(a, index, parent = nil)
    offset  = 1
    return nil if a[index-offset].nil?
    n = Tree.new()
    n.data = a[index-offset]
    n.parent = parent
    n.left = makeTree(a, 2*index, n)
    n.right = makeTree(a, 2*index+1, n)
    return n
  end

  def leaf?(n)
    n.right == nil && n.left == nil
  end

  def to_s
     "#{self.data}..#{self.parent_node}"
  end
end

def isBST(node, min, max)
  return true if node.nil?
  current = node.data

  if min!= nil && node.left.data < min
    isBST(node.left, node.left.data,max)
  end

  if max!= nil && node.right.data > min
    max = node.right
    isBST(node.right, min,max)
  end


  left_child_valid = node.left ? current > node.left.data : true
  right_child_valid = true
  if node.right
    right_child_valid = current <= node.right.data
    right_child_valid &&= node.right.data < parent.data if parent
  end

  p "node is #{node.data} leftchild #{left_child_valid}  right valid rc #{right_child_valid}"
  if (left_child_valid && right_child_valid)
    parent = node
    isBST(node.left,node) && isBST(node.right,node)
  else
    p node.data
    p parent
    false
  end
end

def in_order_successor(node)
end

def print_tree(node, level = 0)
  unless node == nil
    indent = level > 0 ? sprintf("%#{level * 2}s", " ") : ""
    parent_node = node.parent ? node.parent.data : ""
    puts "#{indent}-#{node.data}..#{parent_node}"
    print_tree(node.left, level+1)
    print_tree(node.right, level+1)
  end
end

def preOrderTraversal(n)
  return "" if n.nil?
  print "#{n.data} ,"
  preOrderTraversal(n.left)
  preOrderTraversal(n.right)
end

def inOrderTraversal(n)
  return '' if n.nil?
  inOrderTraversal(n.left)
  print "#{n.data} ,"
  inOrderTraversal(n.right)
end


def inorder_successor(n)
  if n.leaf?(n)
    if n.parent.left == n
      return n.parent
    end

    if n.parent.right == n
       parent = n.parent
       return parent.nil? ? nil : parent.parent
    end
  end

  if n.right == nil
    return n.parent
  end

  if n.right != nil
    return in_order_successor(n.right)
  end
end

# n = Tree.makeTree([5,3,4,1,2,13,10,12],1)
# p "input #{[5,3,4,1,2,13,10,12]}"
# p preOrderTraversal(n)
# print_tree(n)
# p inOrderTraversal(n)
# p isBST(n)

n = Tree.makeTree([10,8,15,3,9,13,18],1)#,1,2,5,8,11,12,19,20],1)
print_tree(n)
# p inOrderTraversal(n)
p inorder_successor(n.left)
p inorder_successor(n.right)
p inorder_successor(n.left.right)
# p preOrderTraversal(n)
# p isBST(n)
