
require 'ostruct'

def find_contiguous_array(array, sum: s)
  h = Hash.new
  # array.each_with_index do |e,i|
  #   h[e] = i
  # end

  running_sum = array[0]
  array = array.drop(1)
  offset = 1
  array.each_with_index do |element, i|
    p 'here'
    p i
    p element
    running_sum = running_sum + element
    if h.has_key?(running_sum - sum)
      # p "key: #{running_sum}..#{element} #{i + offset}"
      return  OpenStruct.new(begin: h[running_sum - sum] + 1, end: i+offset)
    else
      # p "n: #{running_sum}..#{element} #{i + offset}"
      h[running_sum] = i + offset
    end
  end
end


a = [10, 2, 6, 1, 2, 4, 7, -4, 0, 4]
puts find_contiguous_array(a,sum: 3)
# puts find_contiguous_array(a,sum: 0)
