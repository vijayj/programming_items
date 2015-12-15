

def sort(a, sort_method: :quick)
  p "sort method -#{sort_method}.input array - #{a}"
  case sort_method
    when :quick
      qsort(a,0,a.length-1)
    when :merge
      merge_sort(a, 0, a.length-1)
  end
end

def merge_sort(a, start_index, end_index)
  return [a[start_index]] if start_index == end_index
  return [] if start_index > end_index

  middle = (start_index+end_index)/2
  left = merge_sort(a, start_index, middle)
  right = merge_sort(a, middle+1, end_index)

  merge(left, right)
end

def merge(left, right)
  merged_array = Array.new(left.size + right.size)
  li = 0
  ri = 0

  indexOfMergedArray = 0
  while(li < left.length && ri < right.length)
    result = compare(left[li], right[ri])
    if result <= 0
      merged_array[indexOfMergedArray] = left[li]
      li += 1
    else
      merged_array[indexOfMergedArray] = right[ri]
      ri += 1
    end
    indexOfMergedArray += 1
  end

  #merge remainder
  if li == left.length
    merge_rest(merged_array, indexOfMergedArray, right, ri )
  else
    merge_rest(merged_array, indexOfMergedArray, left, li )
  end

  merged_array
end


def compare(left, right)
    left <=> right
end

def merge_rest(destination_array, index, source_array, si)
  si.upto(source_array.length-1) do |i|
    destination_array[index] = source_array[si]
    index += 1
  end
end

def qsort(a,start_index, end_index)
  if start_index < end_index
    pindex = partition(a,start_index,end_index)
    # p "array p index #{pindex} .. sort #{a}"
    qsort(a,start_index, pindex-1)
    qsort(a, pindex+1, end_index)
  end
end

def partition(a, start_index, end_index)
  randomize_pivot(a, start_index, end_index)
  pivot = a[end_index]
  p_index = start_index
  start_index.upto(end_index-1) do |i|
    if a[i] <= pivot
      swap(a, i, p_index)
      p_index += 1
    end
  end

  swap(a, p_index, end_index)


  return p_index
end

def randomize_pivot(a, start_index, end_index)
  rand = rand(end_index - start_index)
  swap(a, rand+start_index, end_index)
  # p "rand...#{rand}..#{end_index}"
end

def swap(a, i,j)
  temp = a[j]
  a[j] = a[i]
  a[i] = temp
end

a = [6, 28, 22, 10, 25, 8, 26, 10, 12, 14]
sort(a)
p "sorted #{a}"

a = [6, 28, 22, 10, 25, 8, 26, 10, 12, 14]
b = sort(a, sort_method: :merge)
p "sorted #{b}"


# a = [6, 28, 22, 10, 25, 8, 26, 10, 12, 14]
# sort(a)
# p "sorted #{a}"
