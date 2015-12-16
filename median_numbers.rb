#numbers are constantly being generated..
#get me a median...

require_relative 'heap'

class Heap
  def insert(element)
    @backing_store << Node.new(element)
    @heap_size = @backing_store.size

    # parent_index = @heap_size/2
    sift_up(@heap_size)
  end

  def sift_up(index)
    # p "index is #{index}..size is #{@heap_size}"
    parent_index = index/2
    return if parent_index == 0

    #compare left and right child
    largest_node = parent_node = get_element(parent_index)
    largest_index = parent_index

    left_child = get_element(index)
    if !@comparator.call(largest_node, left_child)
      largest_node = left_child
      largest_index = index
    end

    if largest_node != parent_node
      exchange(parent_index, largest_index)
    end

    sift_up(parent_index)
  end
end

class MedianGenerator
  attr_reader :min_heap, :max_heap

  def initialize
    min_comparator = lambda { |x,y| (x <=> y) <= 0 }
    @min_heap = Heap.new([],min_comparator)
    @max_heap = Heap.new([], lambda { |x,y| (x <=> y) > 0 })
  end

  def insert(number)
    top = min_heap.top
    if top && number <= top.value
      min_heap.insert(number)
    else
      max_heap.insert(number)
    end

    rebalance_if_necessary
  end

  def size_difference
    difference = (min_heap.size - max_heap.size).abs
  end

  def rebalance_if_necessary
    if size_difference >= 2
      if min_heap.size > max_heap.size
        move_element_from(min_heap,max_heap)
      else
        move_element_from(max_heap,min_heap)
      end
    end
  end

  def move_element_from(source, destination)
    while(size_difference >= 2)
      element = source.extract_top
      destination.insert(element)
    end
  end

  def median
    min_top = min_heap.top ? min_heap.top.value : 0
    max_top = max_heap.top ? max_heap.top.value : 0
    (min_top + max_top)/2
  end
end

p 'start median generator'
m  = MedianGenerator.new

[3,4,5,10,9,2,16,7,-11,28,118,115,3,14].each do |number|
  m.insert(number)
  p "median #{m.median}" if number%4
end

p "min heap"
m.min_heap.print_heap
p "max heap"
m.max_heap.print_heap
