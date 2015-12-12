require 'benchmark'

p ARGV.count
raise "need haystack" if ARGV[0].nil?

haystack = ARGV[0].split(' ').join()
p haystack


def match_with_permutation(source, target)
  source.chars.sort() == target.chars.sort()
end

def is_present_including_permutation(string_to_find, haystack)
  found = false

  length = string_to_find.length
  haystack_length = haystack.length;
  if(haystack_length > length)
    index = 0
    while(index < haystack_length)
      string_from_haystack  = haystack[index, length]
      # p string_to_find
      # p string_from_haystack

      if match_with_permutation(string_to_find,string_from_haystack)
        found = true
        break
      else
        index += 1
      end
    end
  end

  found
end

while(true)
  p "send a string"
  input = STDIN.gets()
  p is_present_including_permutation(input.chomp(), haystack)
end
