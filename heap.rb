
class Node
  # attr_acessor: left, right, value
  # def is_filled?
  #   left != nil && right != nil
  # end
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def <=>(node)
    value <=> node.value
  end

  def to_s
    value.to_s
  end
end


class Heap

  def initialize(a = [], comparator = nil)
    @comparator = comparator || lambda { |x,y| (x <=> y) > 0 }
    @backing_store = []
    a.each { |x| @backing_store << Node.new(x) }
    @heap_size = a.size
    puts "before all" ; p @backing_store.map(&:to_s); p "heap size #{@heap_size}"
    heapify_all()
  end

  def heapify_all
    last_non_leaf_node = @heap_size/2
    last_non_leaf_node.downto(1) do |index|
      # p "heap start node #{index}"
      heapify(index)
    end
  end
  # def insert(element)
  # end

  def heapify(index = 1)
      left = 2*index
      right = left + 1
      current_node = get_element(index)

      # p "debug"
      # p "left #{left} right #{right} current_index #{index}..current #{current_node} "

      largest_node = current_node
      largest_index = index;

      if left <= @heap_size
        left_child = get_element(left)
        if !@comparator.call(largest_node, left_child)
          largest_node = left_child
          largest_index = left
        end
      end

      if right <= @heap_size
        right_child = get_element(right)
        if !@comparator.call(largest_node, right_child)
          largest_node = right_child
          largest_index = right
        end
      end

      if largest_node != current_node
        #swap with largest node...
        # p "swap L : #{largest_node} at  #{largest_index} with small: #{current_node} at  #{index}"
        exchange(index, largest_index)
        heapify(largest_index)
      end
  end

  def extract_top
    root_node = get_element(1)
    #move the last node to root and apply heapify
    last_node = get_element(@heap_size)
    set_element(1, last_node)
    @backing_store.pop
    @heap_size -= 1
    if @heap_size > 0
      heapify
    end
    return root_node.value
  end

  def exchange(source_index, destination_index)
    temp = get_element(destination_index)
    source = get_element(source_index)
    set_element(destination_index, source)
    set_element(source_index, temp)
  end

  def get_element(index)
    raise "error #{index}..#{@heap_size}" if index > @heap_size || index == 0
    @backing_store[index - 1]
  end

  def set_element(index, node)
    raise "error #{index}..#{@heap_size}" if index > @heap_size || index == 0
    @backing_store[index - 1] = node
  end

  def print_heap
    @backing_store.each_with_index { |element, index| p  "#{index}: #{element.to_s}" }
  end
end

h  = Heap.new([1,2,3,4,5], lambda { |x,y| (x <=> y) > 0 })
h.print_heap

print "-------------\n"

arr = [26, 8, 20, 11, 12, 19, 10, 16, 8, 15]
h  = Heap.new(arr)
h.print_heap

#heap sort...
for i in 0...arr.size
  p h.extract_top
end
