def add(n1, n2)
  b1 = n1.to_s(2)
  b2 = n2.to_s(2)
  p b1
  p b2

  b1 = b1.chars.reverse.join
  # p b1

  b2 = b2.chars.reverse.join
  # p b2


  if b1.size >= b2.size
    larger = b1
    smaller = b2
  else
    larger = b2
    smaller = b1
  end

  result = Array.new(b1.size(),0)
  carry  = 0
  last_index = b1.size - 1
  0.upto(last_index) do |i|
    bit1 = b1[i].to_i
    bit2 = b2[i].to_i

    result[i] = bit1 ^ bit2 ^ carry
    # p "index #{i}..#{bit1}..#{bit2}..#{carry}..result #{result[i]}"
    carry = (bit1 & bit2) | (carry & (bit1 ^ bit2))
  end


  result << 1 if carry == 1
  p "res in reverse..#{result.reverse}"

  sum = 0
  result.each_with_index do |e, i|
    if result[i] == 1
      # p "sum..#{sum}..index#{i}..power#{2**i}"
      sum += 2**i
    end
  end
  sum

end


p add(123,20)
