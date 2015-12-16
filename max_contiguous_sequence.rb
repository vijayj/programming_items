require 'ostruct'


def find_index(max, max_sum_array, list)
  # p max_sum_array
  # p max
  # p list
  index  = last_index  = max_sum_array.index(max)

  while(index > 0)
    max -= list[index]
    break if max == 0
    index -= 1
  end

  [index, last_index-index+1]
end

def max_contiguous_sequence(list)
  max_sum_array = Array.new(list.size)
  i = 0
  # fixnumMin = -(2**(0.size * 8 -2))

  return OpenStruct.new(found: false) if list.empty?
  max_sum_array[0] = list[0]

  index = 1
  max_sum = list[0]
  while(index < list.length)
    element = list[index]
    sum_so_far = max_sum_array[index-1]
    largest = [sum_so_far + element, element].max
    max_sum_array[index] = largest
    if largest > max_sum
      max_sum = largest
    end
    index+=1
  end

  result  = OpenStruct.new(found: true)
  result.max_sum = max_sum
  result.max_sum_array = max_sum_array
  result.original_list = list
  result.start_index, result.length = find_index(max_sum, max_sum_array, list)
  result
end



puts max_contiguous_sequence([])
puts max_contiguous_sequence([1])
puts max_contiguous_sequence([-1,-2])
puts max_contiguous_sequence([-1,-2,1])
puts max_contiguous_sequence([-1,-2,1,-1,1,1])
puts max_contiguous_sequence([6, -8, 4, 0, -4, 5, 8, -7, 5, 8])
puts max_contiguous_sequence([2,2,0,-1,-15,1,3,-3,-4,-5,12,2])
