
def knows(p1, p2)
  dict = {
    'A'=> ['E','H'],
    'J'=> ['A', 'H'],
    'C'=>['A', 'H', 'E'],
    'E'=>['H'],
    'D'=>['A','H'],
    'H'=>[]
  }

  # dict = {
  #   'A'=> ['E'],
  #   'C'=>['A',  'E'],
  #   'D'=>['A'],
  #   'E'=>[]
  # }
  return dict[p1].include?(p2)
end

def is_celebrity(list)
  raise 'error nil' unless list
  return nil if list.empty? || list.length == 1

  i=0
  j=1

  # not_a_celebrity = Set.new()
  potential_celebrity = nil

  p list
  while((i < list.length-1) && (j < list.length ))
   result =  knows(list[i],list[j])
   potential_celebrity = list[i]
   if result
    potential_celebrity = list[j]
    i=j
    j=i+1
   else
    j+=1
   end
  end


  p potential_celebrity

  if potential_celebrity
    list.each do |person|
      if person != potential_celebrity && !knows(person, potential_celebrity)
        potential_celebrity = nil
        break
      end
    end
  end

  potential_celebrity
end



list = ['J','D','A','C','H','E']
p is_celebrity(list)

list = ['J','D','A','C','E','H']
p is_celebrity(list)

list = ['H','D','A','C','E','A']
p is_celebrity(list)

# list = ['D','A','E','C']
# p is_celebrity(list)
