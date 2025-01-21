class Node
  attr_accessor :value, :left, :right

  def initialize(value)
    @value = value
  end
end

class BinarySearchTree
  def insert(value)
    @root = insert_recursive(@root, value)
  end

  def insert_recursive(node, value)
    if node.nil?
      return Node.new(value)
    end

    if value < node.value
      node.left = insert_recursive(node.left, value)
    else
      node.right = insert_recursive(node.right, value)
    end

    return node
  end

  def delete(value)
    @root = delete_recursive(@root, value)
  end

  def delete_recursive(node, value)
    return nil if node.nil?

    if value < node.value
      node.left = delete_recursive(node.left, value)
    end

    if value > node.value
      node.right = delete_recursive(node.right, value)
    end

    if value == node.value
      return node.left if node.right.nil?
      return node.right if node.left.nil?

      node.value = find_min(node.right).value
      node.right = delete_recursive(node.right, node.value)
    end

    return node
  end

  def find_min(node)
    return find_min(node.left) if node.left
    return node
  end
  

  def find_max(node)
    return find_max(node.right) if node.right
    return node
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

# Example usage of the BinarySearchTree class

bst = BinarySearchTree.new

# Insert values
bst.insert(10)
bst.insert(5)
bst.insert(15)
bst.insert(12)
bst.insert(11)
bst.insert(1)
bst.insert(2)
bst.insert(3)
bst.insert(4)
bst.insert(6)
bst.insert(7)
bst.insert(12)
bst.insert(13)
bst.insert(14)
bst.insert(18)
bst.insert(23)
bst.insert(17)
bst.insert(25)
bst.insert(30)
bst.insert(35)
bst.insert(36)

# Print the tree
puts "Binary Search Tree:"
bst.pretty_print

# Delete a value
bst.delete(10)

# Print the tree after deletion
puts "\nBinary Search Tree after deleting 10:"
bst.pretty_print