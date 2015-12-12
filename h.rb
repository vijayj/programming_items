

def hash_code(s)
  hash_value = 0
  s.each_codepoint do |codepoint|
    hash_value = 33*hash_value^codepoint
  end
  hash_value
end


while true
  p "enter string"
  s = gets
  p hash_code(s)
end
