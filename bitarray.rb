#from github
class BitVector
  ELEMENT_WIDTH = 32

  def initialize(size)
    @field = Array.new((size-1/ELEMENT_WIDTH) +1,0)
  end

  def []=(position,value)
    if value == 1
      @field[position/ELEMENT_WIDTH] |= 1 << (position%ELEMENT_WIDTH)
    else @field[position/ELEMENT_WIDTH] & (1 << (position%ELEMENT_WIDTH)) != 0
      @field[position/ELEMENT_WIDTH] ^= 1 << (position%ELEMENT_WIDTH)
    end
  end

  def [](position)
    @field[position/ELEMENT_WIDTH] & (1 << (position%ELEMENT_WIDTH)) > 0 ? 1 : 0
  end


  # Returns the field as a string like "0101010100111100," etc.
  def to_s
    @field.collect{|ea| ("%032b" % ea).reverse}.join[0..@field.size-1]
  end

 def total_set
    @field.inject(0) { |a,byte| a += byte&1  and byte >>=1 until byte==0;a  }
  end

end


b = BitVector.new(20)
b[1]=1
b[3]=1
puts b

