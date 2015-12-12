class LinkedList

  # class Node
  #   attr_reader :element, :next
  #   def initialize(element, next_pointer)
  #     @element = element
  #     @next = next_pointer
  #   end
  # end

  def initialize(capacity = 0)
    @backing_array = Array.new(capacity)
  end

  def start_pointer
    return 0;
  end

  alias :head :start_pointer

  def is_empty?
    start_pointer == @backing_array.length
  end

  def insert(element)
    @backing_array << element
  end

  def insert(elements)
    @backing_array.concat elements
  end

  def clear
    @backing_array.clear
    @next_pointer = start_pointer
  end

  def next
    @next_pointer ||= start_pointer
    if @next_pointer >= (@backing_array.length - 1)
      @next_pointer = nil
    else
      @next_pointer = @next_pointer += 1
    end
    @next_pointer
  end

  def reset
    @next_pointer = start_pointer;
  end

  def print
    p @backing_array
  end

  def get_element(pointer)
    @backing_array[pointer]
  end

  def remove_element(pointer)
    @backing_array.delete_at(pointer)
  end

  def size
    ptr = start_pointer
    size = 0
    while(get_element(ptr) != nil)
      size += 1
      ptr = self.next
      break if ptr == nil;
    end
    size
  end

end

def remove_duplicate(element, list)
  next_pointer = list.next

  while(next_pointer != nil)
    next_element = list.get_element(next_pointer)
    if (next_element && next_element == element)
      list.remove_element(next_pointer)
    else
      next_pointer = list.next
    end
  end
  list.reset
end

def remove_duplicate_from_list(ll)
  if ll.is_empty?
    return
  end

  start_offset = 0
  current_pointer = ll.start_pointer
  loop do
    element_to_match = ll.get_element(current_pointer)

    #remove dups
    remove_duplicate(element_to_match, ll)

    start_offset += 1
    ll.reset
    #find next element to scan for dups
    steps = 0

    until steps == start_offset do
      current_pointer = ll.next
      steps += 1
    end
    break if current_pointer == nil
    # p start_offset
    # ll.print
  end

end


