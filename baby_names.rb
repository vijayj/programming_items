#Given list of synonyms and frequency counts,  normalize them

require_relative 'graph'

dict = {
  joey: :jo,
  jo: :joe,
  ha: :vi,
  re: :sc,
  and: :coli,
  vi: :re,
  joe: :oy,
  ja: :joey
}

freq = {
  re: 1,
  jo: 3,
  sc: 5,
  joe: 1,
  ja: 3,
  coli: 1,
  oy: 4,
  joey: 3
}

require 'ostruct'

class Graph
  def find_synonym_node(name)
    #do a traversal and assign a count to each related node
    #keep a copy of the first one
    vertex = find_vertex(name)
    if vertex.unique_id != -1
      return search_for_first_node(vertex).name
    else
      #run dfs and assign numbers
      visited = Set.new
      identifier = OpenStruct.new()
      identifier.next_id = 1
      gdfs(vertex, visited, identifier)

      return name
    end
  end

  def search_for_first_node(vertex)
    visited = Set.new
    find_node(vertex, visited, 1)
  end

  def find_node(vertex, visited, id)
    return nil if visited.member?(vertex)

    if vertex.unique_id == id
      return vertex
    end

    node = nil
    visited << vertex
    vertex.edges.each do |v|
      node = find_node(v, visited,id)
      break if node
    end

    return node
  end

  def gdfs(node, visited, identifier)
    return if visited.member?(node)
    node.unique_id = identifier.next_id
    identifier.next_id += 1
    visited << node
    node.edges.each do |v|
      gdfs(v, visited,identifier)
    end
  end
end

$graph = Graph.new

def build_relationships(dict)
  dict.each do |n1,n2|
    # p "adding node #{n1}..#{n2}"
    $graph.add_edge(n1,n2)
    $graph.add_edge(n2,n1)
  end
end



def find_synonym_for_name(name)
  $graph.find_synonym_node(name)
end

def compute_frequencies(freq)
  frequency_counter = Hash.new() {|_,v| v = 0}
  freq.each do |name,count|
     syn = find_synonym_for_name(name)
     frequency_counter[syn] = frequency_counter[syn] + count
  end
  frequency_counter
end

build_relationships(dict)
# p "before numbers"
# $graph.print_graph


# p $graph.find_synonym_node(:jo)
# p $graph.find_synonym_node(:joe)
# $graph.dfs
output =  compute_frequencies(freq)
output.each { |k,v| p "#{k}: #{v}"}
