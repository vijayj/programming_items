
=begin
a and b are long integer in strings
=end
def multiply(a,b)
  length = a.length + b.length
  result = Array.new(length, 0)

  a_length = a.length
  b_length = b.length
  (a_length-1).downto(0) do |i|
    (b_length-1).downto(0) do |j|
      result[i+j+1] += (a[i].to_i)*(b[j].to_i)
      result[i+j] += result[i+j+1]/10
      result[i+j+1] = result[i+j+1]%10
    end
  end

  str = ""
  skip = true
  prefix = 0
  0.upto(result.length-1) do |i|
    next if result[i] == 0
    prefix = i
    break
  end
  result.slice(prefix,result.length).join()
end


p multiply('25','12')
p multiply('12','25')

p multiply('91', '9')
p multiply('1422122123232323', '111')
