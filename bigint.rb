
class BigInt
  attr_reader :digits
  attr_reader :negative

  def size; @digits.length ; end;

  def initialize(str)
    @negative = (str[0] == "-" ? true : false)
    str = str.slice(1,str.length) if @negative

    @digits = Array.new(str.length,0)
    last_index = str.length - 1
    last_index.downto(0) do |i|
      @digits[last_index-i] =  str[i].to_i
    end
  end

  def from_digits(digits, sign=false)
    @negative = sign
    @digits = digits
    self
  end


  def to_s
    r = digits.reverse.join
    r.insert(0,'-') if @negative
    r
  end

  def [](index)
    self.digits[index]
  end

  def []=(index,value)
    self.digits[index] = value
  end

  def +(number)
    if size > number.size
      large = self
      small = number
    else
      large = number
      small = self
    end

    result = Array.new(large.size+1,0)
    carry = 0
    0.upto(large.size-1) do |i|
      result[i] += large[i] + (small[i] || 0) + carry
      if result[i] >= 10
        carry = result[i] % 10
        result[i] = result[i]/10
      else
        carry = 0
      end
    end

    BigInt.new('').from_digits(result)
  end

  # def compare

  # end

   def -(number)
    #more complex matching for sizes
    if size >= number.size
      large = self
      small = number
    else
      large = number
      small = self
    end

    sign = large.negative

    result = Array.new(large.size,0)
    borrow = 0
    0.upto(large.size-1) do |i|
      if large[i] < (small[i] || 0)
        large[i+1] -= 1
        result[i] = (large[i]+10) - (small[i] || 0)
      else
        result[i] = large[i] - (small[i] || 0)
      end
    end

    BigInt.new('').from_digits(result, sign)
  end

  def self.add(s1,s2)
    b1 = BigInt.new(s1)
    b2 = BigInt.new(s2)
    b1 + b2
  end

  def self.subtract(s1,s2)
    b1 = BigInt.new(s1)
    b2 = BigInt.new(s2)
    b1 - b2
  end
end



def calculate(s1,s2, operator = '+')
  case operator
    when '+'
      r =  BigInt.add(s1,s2)
      p "sum of #{s1}, #{s2} is #{r}"
    when '-'
      r =  BigInt.subtract(s1,s2)
      p "sum of #{s1}, #{s2} is #{r}"
  end
end


calculate('1231212','123')
calculate('43221','34234')
calculate('5000','21')
calculate('5000','21', '-')
calculate('-5000','21', '-')
calculate('9010','8456', '-')
# calculate('-5000','21', '-')
# calculate('21','5000', '-')

# BigInt.subtract('5010', '21')
