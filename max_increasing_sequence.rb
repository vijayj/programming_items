require 'ostruct'

def make_a_list_from_height_weight(a)
  list = Array.new(a.size)
  a.collect do |element|
    OpenStruct.new(height:element[0],weight:element[1])
  end
end

def max_persons_in_circus(list)
  list.sort! { |x,y| x.height <=> y.height }
  p list
end

def find_sequence_list(max_sequence_array, max_sequence_array_index, list)
  # p max_sequence_array
  # p max_sequence_array_index
  max_index = max_sequence_array.index(max_sequence_array.max)

  sequence_list = [list[max_index]]

  new_index = max_sequence_array_index[max_index]
  while(new_index != -1)
    sequence_list << list[new_index]
    new_index = max_sequence_array_index[new_index]
  end

  sequence_list.reverse
end

def max_increasing_sequence(list)
  max_sequence_array = Array.new(list.size) { 1 }
  max_sequence_array_index = Array.new(list.size) { -1 }

  return OpenStruct.new(found: false) if list.empty?
  return OpenStruct.new(found: true, length:1, list: list) if list.length == 1

  i = 1
  while(i < list.length)
    j = 0
    while(j < i)
      if list[j] < list[i] && (max_sequence_array[i] < max_sequence_array[j] + 1)
        max_sequence_array[i] = max_sequence_array[j] + 1
        max_sequence_array_index[i] = j
      end
      j+=1
    end
    i+=1
  end
  # p "sequence arrat"
  # p max_sequence_array
  # p "---"

  length = max_sequence_array.max
  sequence_list = find_sequence_list(max_sequence_array, max_sequence_array_index, list)
  return OpenStruct.new(found: true, length:length, list: sequence_list, original_list:list)
end


# (65, 100) (70, 150) (56, 90) (75, 190) (60, 95) (68, 110)
# a = [[65,100],[70,150],[56,90],[75,190],[60,95],[68,110]]
# list = make_a_list_from_height_weight(a)
# puts max_persons_in_circus(list)

puts max_increasing_sequence([])
puts max_increasing_sequence([1])
puts max_increasing_sequence([-1,-2])
puts max_increasing_sequence([-1,-2,-1])
puts max_increasing_sequence([-2,-1,1,-1,2,1])
puts max_increasing_sequence([6, -8, 4, 0, -4, 5, 8, -7, 5, 8])
puts max_increasing_sequence([2,2,0,-1,-15,1,3,-3,-4,-5,12,2])

