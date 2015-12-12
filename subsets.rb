require 'set'

def combine(element, list_of_sets)
  sets_with_element = [Set.new([element])]
  list_of_sets.each { |subset| dup = subset.clone(); dup.add(element); sets_with_element <<  dup  }
  sets_with_element
end

def subsets(array)
  return [Set.new] if nil
  element = array[0]
  return [Set.new([element])] if array.length == 1
  s = subsets(array[1, array.length])
  add_self_to_all_subsets(element, s)
end

def add_self_to_all_subsets( element, list_of_sets)
  p 'sets'
  p list_of_sets
  subsets_with_self = combine(element, list_of_sets)
  p 'self'
  p subsets_with_self
  list_of_sets.concat(subsets_with_self)
end


p subsets([1,4,5])
