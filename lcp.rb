require 'ostruct'
class TrieNode
  attr_reader :nodes
  attr_reader :key

  # def self.terminationNode
  #   @terminationNode ||= TrieNode.new("*")
  #   @terminationNode
  # end

  def inspect
    "#<letter: #{key.inspect || 'nil'}, children: #{nodes.count}>"
    self.nodes.each { |x| p x }
  end

  def initialize(character)
    @key = character
    @nodes = {}
  end

  def add(word,index,length)
    ch = word[index]
    if index >= length
      node = TrieNode.new("*")
    else
      if nodes.has_key?(ch)
        trie_node = nodes[ch]
        trie_node.add(word,index+1, length)
      else
        node = TrieNode.create(word, index,length)
        nodes[ch] = node
      end
    end

    # raise "#{word}..#{index}..#{length}" if ch.nil?

  end

  def self.create(word,start_index, length)
    # p "#{word[start_index]},#{start_index}, #{length}"
    node = TrieNode.new(word[start_index])
    node.add(word, start_index +1 , length)
    node
  end


  def dfs(depth=0, prefix, results)
    return if key == "*"

    if nodes.length >=2
      # p "#{nodes.length}, #{depth}"
      results << OpenStruct.new(prefix: prefix, length: depth)
    end

    nodes.keys.each do |k|
      nodes[k].dfs(depth+1, prefix + k, results)
    end
  end
end

class Trie
  attr_reader :root
  def initialize
    @root = TrieNode.new('root')
  end

  def add(word)
    root.add(word,0,word.length)
  end

  def print
    p root
  end

  def lcp
    depth=0
    results = []
    root.dfs(0, "", results)
    p results
    results.max { |r1, r2| r1.length <=> r2.length }
  end
end

def lcp(*strs)
  return "" if strs.empty?
  min, max = strs.minmax
  p min
  p max
  idx = min.size.times{|i| break i if min[i] != max[i]}
  min[0...idx]
end

def lcp_trie(strs)
  t = Trie.new
  strs.each { |w| t.add(w) }
  t.print
  t.lcp
end

data = [
  ["interspecies","interstellar","interstate"],
  ["interspecies","foobars", "interstellar", "moscone center", "interstate"],
  ["throne","throne"],
  ["throne","dungeon"],
  ["throne","","throne"],
  ["cheese"],
  [""],
  [],
  ["prefix","suffix"],
  ["foo","foobar"]
]

data.each do |set|
  puts "lcp(#{set.inspect[1..-2]}) = #{lcp(*set).inspect}"
end

p "#TRIE#"
set =  data.slice(1)
# data.each do |set|
  puts "lcp(#{set.inspect[1..-2]}) = #{lcp_trie(set).inspect}"
# end

# words = data[1]
# t = Trie.new
# words.each { |w| t.add(w) }
# t.print

