
class Tree

  def has_right?(root)
    root.right
  end

  def has_left?(root)
    root.left
  end

  def to_s()
    return "" if self.root.nil?
    result = ''

    if has_right?(root)
      print_node(result, ' ', true, root.right)
      result << " |\n"
    end

    result << "-o #{self.root.data} (root) #{self.root.size}\n"

    if has_left?(root)
      result << " |\n"
      print_node(result, ' ', false, root.left)
    end

    result
  end

  def print_node( result, line, right, index )
      if has_right?(index)
        print_node(result, line + (right ? '  ' : '| '), true,
                   index.right)
        result << "#{line}#{right ? ' ' : '|'} |\n"
      end

      result << "#{line}+-o #{index.data} (#{index.parent.data}) #{index.size}\n"

      if has_left?(index)
        result << "#{line}#{right ? '|' : ' '} |\n"
        print_node(result, line + (right ? '| ' : '  '), false,
                   index.left)
      end
  end

end

class TreeNode
  def has_right?(root)
    self.right
  end

  def has_left?(root)
    self.left
  end

  def right_index(index)
    true
  end

  alias_method :left_index, :right_index

  def print_node( result, line, right, index )
      if has_right?(index)
        print_node(result, line + (right ? '  ' : '| '), true,
                   right_index(index))
        result << "#{line}#{right ? ' ' : '|'} |\n"
      end

      result << "#{line}+-o #{self.data} #{self.parent} #{self.size}\n"

      if has_left?(index)
        result << "#{line}#{right ? '|' : ' '} |\n"
        print_node(result, line + (right ? '| ' : '  '), false,
                   left_index(index))
      end
  end
end

