require_relative 'll'
require 'ostruct'


def is_palindrome?(list,size, current)

  case size
  when 0
    #when would this happen ?
    return OpenStruct.new(node: nil, match: true)
  when 1
    return OpenStruct.new(node: current, match: true)
  when 2
    next_ptr = list.next_ptr
    return OpenStruct.new(node: next_ptr, match: list.get_element(current) == list.get_element(next_ptr) )
  end

  #3..
  # next_node = result.next_ptr
  result =  is_palindrome?(list, size - 2, current.next_ptr)
  if(result.match)
    midpoint_node = result.node
    element = midpoint_node.next_ptr
    current_element = element
    result = OpenStruct.new(node: element.next_ptr, match:  )
  end

  raise 'error'
end


def run_test(elements)
  l = LinkedList.new
  l.reset()
  l.insert(elements)
  p is_palindrome?(l, l.size, l.head)
end


run_test([])

run_test([1])

run_test([1,1])

run_test([1,2])

run_test([1,2,1])

run_test([1,2,3])
