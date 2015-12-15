require 'set'

class Graph
  class Vertex
    attr_accessor :inbound
    attr_accessor :name
    attr_accessor :edges
    attr_accessor :unique_id

    def initialize(name, inbound = 0)
      self.name = name
      self.inbound = inbound
      self.edges = Set.new()
      self.unique_id = -1
    end


    def add_edge_to(v)
      v.inbound += 1
      self.edges.add(v)
    end

    def outbound
      self.edges.count
    end

    def to_s
      "#{self.name} inbound: #{self.inbound} outbound: #{self.outbound} #{self.unique_id}"
    end
  end

  attr_reader :adjacency_list

  def initialize()
    @adjacency_list = Array.new
  end

  def add_edge(v1, v2)

    vertex1 = find_vertex(v1) || create_vertex(v1)
    vertex2 = find_vertex(v2) || create_vertex(v2)

    vertex1.add_edge_to(vertex2)
  end


  def add_vertex(v)
    vertex = Vertex.new(v,0)
    self.adjacency_list << vertex
    vertex
  end

  alias_method :create_vertex, :add_vertex

  def find_vertex(name)
    adjacency_list.find { |vertex| vertex.name == name }
  end

  def print_graph
    adjacency_list.each do |element|
      p "#{element.name}: #{element.edges.map(&:name)}"
    end
  end

  def bfs()
    p "BFS"
    visited = Set.new
    queue = Array.new()
    queue << adjacency_list.first

    while(!queue.empty?)
      node = queue.shift
      next if visited.member?(node)
      visit(node)
      visited << node
      queue.concat(node.edges.to_a)
    end
  end

  def dfs()
    p "DFS"
    visited = Set.new
    adjacency_list.each do |node|
      recdfs(node, visited)
    end
  end

  def visit(v)
    p v.to_s
  end

  def recdfs(vertex, visited)
    return if visited.member?(vertex)
    visit(vertex)
    visited << vertex
    vertex.edges.each do |e|
      recdfs(e, visited)
    end
  end

end

g = Graph.new
g.add_edge('A','B')
g.add_edge('A','C')
g.add_edge('E','B')
g.add_edge('D','E')
g.add_vertex('F')


g.dfs

g.bfs




