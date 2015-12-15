

def isEditDistanceMatch(source, destination)
  if (source.length < destination.length)
    temp = source
    source = destination
    destination = temp
  end

  i = 0;j = 0;cost = 0;
  while(i < source.length)
    break if cost > 1
    if match?(source[i], destination[j])
      i += 1
      j += 1
      next
    else
      #delete.. or replace
      delete_case = source[i+1, source.length] == destination[j,destination.length]
      if delete_case
        i = i+1
      else  source[i+1, source.length] == destination[j+1,destination.length]
        i = i+1
        j = j+1
      end
      cost += 1
    end
  end

  puts "#{source}..#{destination}"
  i == j
end

def match?(a, b)
  a == b
end

p isEditDistanceMatch("abc","abc")
p isEditDistanceMatch("abc","dbc")
p isEditDistanceMatch("abcd","abc")
p isEditDistanceMatch("abc","abcd")
p isEditDistanceMatch("abc","adb")
p isEditDistanceMatch("grow","seed")
