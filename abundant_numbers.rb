require 'set'

def sum_all_numbers(list_of_integers)
  set_of_numbers = Set.new
  list_of_integers.each do |integer|
    list_of_integers.each do |inner_number|
      set_of_numbers << integer + inner_number
    end
  end
  set_of_numbers
end

def proper_factors(number)
  factors = []
  upper_bound_for_divisor = number/2
  1.upto(upper_bound_for_divisor) do |potential_divisor|
    factors <<   potential_divisor if number%potential_divisor == 0
  end
  # factor = factors + (2...(number/2)).each.select { |potential_divisor| number%potential_divisor == 0 }
  factors
end

def is_abundant_number?(number)
  factors = proper_factors(number)
  sum_of_factors = factors.reduce(:+)
  sum_of_factors > number
end

def non_abundant_sums(upper_bound: 28123)
  abundant_numbers = []
  (12..upper_bound).each do |number|
    abundant_numbers <<  number if is_abundant_number?(number)
  end

  # p "upper bound", upper_bound
  # p "abundant length", abundant_numbers.length

  set_sum_of_all_abundant_numbers = sum_all_numbers(abundant_numbers)
  # p set_sum_of_all_abundant_numbers.length

  # sum_of_all_abundant_numbers = list_of_sums.reduce(:+) || 0
  series_with_all_numbers_that_are_not_abundant = 1.upto(28123).reject do
    |number|  set_sum_of_all_abundant_numbers.include?(number)
  end

  series_with_all_numbers_that_are_not_abundant.reduce(:+)
end


unless ARGV[0].nil?
  puts " non abundant sums", non_abundant_sums(upper_bound: ARGV[0].nil? ? nil : ARGV[0].to_i)
else
  puts " non abundant sums", non_abundant_sums
end

