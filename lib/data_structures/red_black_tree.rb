class Node
  RED = true
  BLACK = false

  attr_accessor :value, :left, :right, :parent, :color

  def initialize(parent, value)
    @color = RED
    @value = value
    @parent = parent
  end

  def grandfather
    parent&.parent
  end

  def sibling
    return nil if parent.nil?
    self == parent.left ? parent.right : parent.left
  end

  def uncle
    g = grandfather
    return nil if g.nil?
    g.left == parent ? g.right : g.left
  end
end

class RedBlackTree
  def find_min(node)
    return find_min(node.left) if node.left
    return node
  end
  

  def find_max(node)
    return find_max(node.right) if node.right
    return node
  end

  def insert(value)
    current = @root
    parent = nil

    while current
      parent = current
      current = value < current.value ? current.left : current.right
    end

    new_node = Node.new(parent, value)

    if parent.nil?
      @root = new_node
    elsif value < parent.value
      parent.left = new_node
    else
      parent.right = new_node
    end

    insert_fixup(new_node)
  end

  def insert_fixup(node)
    # case 1 the node is the root of the tree
    if node.parent.nil?
      node.color = Node::BLACK
      return
    end
    
    # case 2 the node's parent is black
    if node.parent.color == Node::BLACK
      return
    end

    # case 3 the node's uncle is red
    uncle = node.uncle

    if uncle && uncle.color == Node::RED
      node.parent.color = Node::BLACK
      uncle.color = Node::BLACK
      grandfather = node.grandfather
      grandfather.color = Node::RED
      insert_fixup(grandfather)
      return
    end

    # case 4 the node's parent is red but its uncle is black and node is right child while its parent is a left child or vice versa
    target = node
    grandfather = node.grandfather

    if node == node.parent.right && node.parent == grandfather.left
      left_rotation(node.parent)
      target = node.left
    elsif node == node.parent.left && node.parent == grandfather.right
      right_rotation(node.parent)
      target = node.right
    end

    # case 5 the node's parent is red but its uncle is black and node is left child while its parent is also a left child or vice versa
    grandfather.color = Node::RED
    target.parent.color = Node::BLACK
    if target == target.parent.left && target.parent == grandfather.left
      right_rotation(grandfather)
    else
      left_rotation(grandfather)
    end
  end

  def delete(value)
    node = search(value)

    return unless node

    if node.left.nil? || node.right.nil?
      delete_fixup(node)
    else
      successor = find_max(node.left)
      node.value = successor.value

      delete_fixup(successor)
    end
  end

  def delete_fixup(node)
    child = node.left || node.right

    # case 1 node is red
    if node.color == Node::RED
      replace(node, child)
      return
    end

    # special case; node is a leaf node
    if child.nil?
      delete_case_3(node)
      replace(node, child)
      return
    end

    replace(node, child)

    # case 2 node's child is red
    if child && child.color == Node::RED
      child.color = Node::BLACK
      return
    end

    # case 3 node and its child are black
    if child
      delete_case_3(child)
    else
      delete_case_3(node)
    end
  end

  def delete_case_3(node)
    # case 3.1 node is the root, nothing to do
    return unless node.parent

    sibling = node.sibling

    # case 3.2 sibling is red
    if node_color(sibling) == Node::RED
      sibling.color = Node::BLACK
      node.parent.color = Node::RED
      if node == node.parent.left
        left_rotation(node.parent)
      else
        right_rotation(node.parent)
      end
    end

    # case 3.3 parent, sibling, and sibling's children are black
    sibling = node.sibling # need to recalculate the sibling, it may have changed after rotation
    # TODO - maybe checking sibling != nil is not needed
    if node.parent.color == Node::BLACK && sibling && node_color(sibling) == Node::BLACK && node_color(sibling.left) == Node::BLACK && node_color(sibling.right) == Node::BLACK
      sibling.color = Node::RED
      delete_case_3(node.parent)
      return
    end

    # case 3.4 parent is red but sibling and sibling's children are black
    sibling = node.sibling # need to recalculate the sibling, it may have changed after rotation
    # TODO - maybe checking sibling != nil is not needed
    if node.parent.color == Node::RED && sibling && node_color(sibling) == Node::BLACK && node_color(sibling.left) == Node::BLACK && node_color(sibling.right) == Node::BLACK
      sibling.color = Node::RED
      node.parent.color = Node::BLACK
      return
    end

    # case 3.5 sibling is black but its left child is red and right child is black
    if node == node.parent.left && sibling && node_color(sibling) == Node::BLACK && node_color(sibling.left) == Node::RED && node_color(sibling.right) == Node::BLACK
      sibling.color = Node::RED
      sibling.left.color = Node::BLACK
      right_rotation(sibling)
    elsif node == node.parent.right && sibling && node_color(sibling) == Node::BLACK && node_color(sibling.left) == Node::BLACK && node_color(sibling.right) == Node::RED
      sibling.color = Node::RED
      sibling.right.color = Node::BLACK
      left_rotation(sibling)
    end

    # case 3.6
    sibling = node.sibling
    sibling.color = node.parent.color
    node.parent.color = Node::BLACK
    if node == node.parent.left
      sibling.right.color = Node::BLACK if sibling.right
      left_rotation(node.parent)
    else
      sibling.left.color = Node::BLACK
      right_rotation(node.parent)
    end
  end

  def replace(node, child)
    if node.parent.nil?
      @root = child
    elsif node == node.parent.left
      node.parent.left = child
    else
      node.parent.right = child
    end

    child.parent = node.parent if child
  end

  def node_color(node)
    node ? node.color : Node::BLACK    
  end

  def right_rotation(node)
    root = node.left
    root.parent = node.parent

    if node.parent.nil?
      @root = root
    elsif node.parent.left == node
      node.parent.left = root
    else
      node.parent.right = root
    end

    node.parent = root
    node.left = root.right
    node.left.parent = node if node.left
    root.right = node
  end

  def left_rotation(node)
    root = node.right
    root.parent = node.parent

    if node.parent.nil?
      @root = root
    elsif node.parent.left == node
      node.parent.left = root
    else
      node.parent.right = root
    end

    node.parent = root
    node.right = root.left
    node.right.parent = node if node.right
    root.left = node
  end

  def search(value, node = @root)
    if node.nil? || node.value == value
      return node
    end

    if value < node.value
      return search(value, node.left)
    else
      return search(value, node.right)
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    return if node.nil?
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value} #{node.color ? 'R' : 'B'}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

rbt = RedBlackTree.new

loop do
  puts "Enter 1 to insert, 2 to delete, or any other key to exit:"
  choice = gets.chomp.to_i

  case choice
  when 1
    puts "Enter value to insert:"
    value = gets.chomp.to_i
    rbt.insert(value)
    rbt.pretty_print
  when 2
    puts "Enter value to delete:"
    value = gets.chomp.to_i
    rbt.delete(value)
    rbt.pretty_print
  else
    break
  end
end