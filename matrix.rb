

require 'matrix'
require 'pp'

def print_matrix(m)
  m.row_vectors.each do |row|
    delim = ""
    row.each do |val|
      print "#{delim} #{val}"
      delim = "\t"
    end
    print "\n"
  end
end


class Matrix
  def []=(i,j,x)
    @rows[i][j] = x
  end
end


# def rotate_corners(matrix, first_row, last_col)

#   # element_2 = matrix[first_row,last_col]
#   # element_3 = matrix[last_col,last_col]
#   # element_4 = matrix[last_col,first_row]


#   element_1  = matrix[first_row,first_row]
#   elem = matrix[first_row, last_col]
#   matrix[first_row,last_col] = element_1
#   element_1 = elem

#   elem = matrix[last_col,last_col]
#   matrix[last_col,last_col] = element_1
#   element_1 = elem

#   elem = matrix[last_col,first_row]
#   matrix[last_col,first_row] = element_1
#   element_1 = elem

#   matrix[first_row,first_col] = element_1
# end

# def rotate_rest(matrix, first_row, last_col)
# end

def rotate(matrix, rank)
  outerlayer = 0;
  i = rank;
  offset = rank
  # while( i > 1) do
    temp = nil
    0.upto(i-2) do |j|
      top = matrix[outerlayer,j]
      temp = top
      p top
      #left to top
      matrix[outerlayer,j] = matrix[offset -1 - j,outerlayer]
      p matrix[offset -1 - j,outerlayer]
      #bottom to right
      matrix[offset -1 - j,outerlayer] = matrix[offset -1,offset -1 - j]
      p matrix[offset -1,offset -1 - j]
      #right to bottom
      matrix[offset -1,offset -1 - j] = matrix[j, offset - 1]
      p matrix[j, offset - 1]
      #top to right
      matrix[j, offset - 1] = temp
    end
    i = rank/2
    offset -= 1
    outerlayer += 1
  # end

end

def rotate_matrix(m, rank, offset = 0)
  first_row = 0 + offset
  last_row = rank
  first_col = 0 + offset
  last_col = rank

  rotate(m,rank)
  # rotate_corners(m, first_row, last_col)
  # rotate_rest(m, first_row, last_col)
end


while(true)
  p "gimme a rank"
  matrix_rank = gets.chomp.to_i
  m = Matrix.build(matrix_rank) { (rand*10).to_i }
  print_matrix m
  puts "rank is  #{m.rank}"

  rotate_matrix(m, m.rank)
  print_matrix m


end

