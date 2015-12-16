#Find median...

#Numbers are generated and stored in a
#find rank for a number (which is all numbers less than given numbers)

require_relative 'tree_print'


class Tree
  class Node
    attr_accessor :data
    attr_accessor :left, :right, :parent
    attr_accessor :count, :size

    def initialize(x)
      @data = x
      @count = 1
      @size = 0
    end

    def insertNode(x)
      if x < self.data
        self.left ? self.left.insertNode(x) :   self.left = Node.new(x)
        self.left.parent = self
        self.size += 1
      elsif x > self.data
        self.right ? self.right.insertNode(x) :   self.right = Node.new(x)
        self.right.parent = self
        self.size += 1
      else
        self.count += 1
      end
    end

    def total_size
      size + count
    end


    def getRank(x)
      rank = -1
      left_size = (self.left ? self.left.total_size : 0)
      if x == self.data
        rank = count + left_size
      elsif x < self.data
        rank = self.left ? self.left.getRank(x) : -1
        # p "left..rank is #{rank} for node #{x}."
        rank = rank == -1 ? -1 : rank
      else  #x > self.data
        rank = self.right ? self.right.getRank(x) : -1
        # p "right..tot size #{total_size}"
        rank = rank == -1 ? -1 : rank + count + left_size
        # p "right..rank is #{rank} for node #{x}."
      end
      return rank
    end
  end

  attr_reader :root


  def track(x)
    if root
      @root.insertNode(x)
    else
      @root = Node.new(x)
    end
  end

  def getRank(x)
    rank = root ? root.getRank(x) : -1
    rank == -1 ? rank : rank - 1
  end
end

t = Tree.new
[5,1,4,4,9,7,13,3].each do |x|
  t.track(x)
end

puts t.to_s

[5,4,9,13,3,100].each do |x|
  p "#{x}..rank #{t.getRank(x)}"
end

# [3].each do |x|
#   p "#{x}..rank #{t.getRank(x)}"
# end

