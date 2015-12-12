require_relative 'plots'




def max_rectangle(h)
  if h.empty?
    return 0
  end

  index = smallest_index(h)

  left = h[0,index]
  right = h[index+1,h.length]

  smallest_height = h[index]

  #assuming width is 1
  area = smallest_height * h.length

  [max_rectangle(left), area , max_rectangle(right)].max
end

def smallest_index(h)
 _, index = h.each_with_index.min
 index
end

a = [6, 2, 5, 4, 5, 1, 6]
p max_rectangle(a)

file_name = plot_histogram(a)
system(`open #{file_name}`)


a = [12, 6, 18, 11, 2, 10, 18, 7, 14, 1]
p max_rectangle(a)
file_name = plot_histogram(a)
system(`open #{file_name}`)


a = [3, 5, 1, 1, 9, 18, 16, 6, 15, 0.5]
p max_rectangle(a)
file_name = plot_histogram(a)
system(`open #{file_name}`)

