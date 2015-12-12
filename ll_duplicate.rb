require_relative 'll'

l = LinkedList.new

l.insert([1,2,4,1,4,2])
l.print
p l.size
remove_duplicate_from_list(l)
l.print
p l.size


l.clear
l.insert([])
l.print
p l.size
remove_duplicate_from_list(l)
l.print
p l.size

l.clear
l.insert([1,2,1,3,2])
l.print
remove_duplicate_from_list(l)
l.print

l.clear
l.insert([1,1,2,1,1,1])
l.print
remove_duplicate_from_list(l)
l.print

l.clear
l.insert([1,1])
p l.size
