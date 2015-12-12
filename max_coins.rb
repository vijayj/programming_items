=begin
Number of paths with exactly k coins
Given a matrix where every cell has some number of coins. Count number of ways to reach bottom right from top left with exactly k coins. We can move to (i+1, j) and (i, j+1) from a cell (i, j).
Input:  k = 12
        mat[][] = { {1, 2, 3},
                    {4, 6, 5},
                    {3, 2, 1}
                  };
Output:  2
There are two paths with 12 coins
1 -> 2 -> 6 -> 2 -> 1
1 -> 2 -> 3 -> 5 -> 1
=end


require 'matrix'


def rec_num_paths(matrix, row, column, number_of_coins, dp_cache = nil)
  row_index = row
  col_index = column



  return 0 if row_index < 0 || col_index < 0

  if row_index == 0 && col_index == 0
    #base case
    # p "bc #{number_of_coins}"
    if matrix[row_index, col_index] == number_of_coins
      # p 'success'
      return 1
    else
      return 0
    end
  end

  coins = matrix[row_index, col_index]
  # p "ri #{row_index}..ci #{col_index} #{number_of_coins}"
  new_coin_count = number_of_coins - coins

  if dp_cache
    already_computed_paths   = dp_cache[row][column][new_coin_count]
    if already_computed_paths
      # p "#{already_computed_paths}"
      return already_computed_paths
    end
  end

  # p "coins #{coins}..nc #{new_coin_count}"
  p1 =  rec_num_paths(matrix,row-1,column,new_coin_count)
  p2 =  rec_num_paths(matrix,row,column-1,new_coin_count)
  # p "paths #{p1} #{p2} #{p1 + p2}"
  p = p1 + p2
  if dp_cache
    dp_cache[row][column][new_coin_count] = p
  end
  return p
end

def get_num_paths(matrix, number_of_coins)
  require 'benchmark'
  n = 5_000_000
  result = nil
  const_k = 1000
  rank = matrix.rank
  dp_cache =  Array.new(rank) { Array.new(rank) { Array.new(const_k) } }
  Benchmark.bmbm do |x|
    x.report("no dp") {
      n.times do
        result = rec_num_paths(matrix, matrix.row_count - 1, matrix.column_count - 1, number_of_coins)
      end
    }

    x.report("dp") {
      n.times do
        result = rec_num_paths(matrix, matrix.row_count - 1, matrix.column_count - 1,number_of_coins, dp_cache)
      end
    }


  end
  result
end


number_of_coins = 12

matrix_with_coins  = Matrix[
  [1,2,3],
  [4,6,5],
  [3,2,1]
]

p "num paths is"
p get_num_paths(matrix_with_coins, number_of_coins)

