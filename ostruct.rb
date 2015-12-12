require 'ostruct'

aStruct1 = OpenStruct.new(aStruct: 'aStruct',b: 'b')
p aStruct1.b

aStruct1.bx = 'bx'

p aStruct1


p (Array.new.methods - Class.new.methods).sort
