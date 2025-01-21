class Node
  attr_accessor :value, :left, :right, :height

  def initialize(value)
    @height = 0
    @value = value
  end
end

class Avl
  def balance_factor(node)
    height(node.left) - height(node.right)
  end

  def find_min(node)
    return find_min(node.left) if node.left
    return node
  end
  

  def find_max(node)
    return find_max(node.right) if node.right
    return node
  end

  def height(node)
    node ? node.height : -1
  end

  def update_height(node)
    node.height = 1 + [height(node.left), height(node.right)].max if node
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

    update_height(node)

    return balance(node)
  end

  def insert(value)
    @root = insert_recursive(@root, value)
  end

  def insert_recursive(node, value)
    if node.nil?
      return Node.new(value)
    end

    if value < node.value
      node.left = insert_recursive(node.left, value)
    end

    # no duplicates allowed
    if value > node.value
      node.right = insert_recursive(node.right, value)
    end

    update_height(node)

    return balance(node)
  end

  def left_rotation(node)
    root = node.right
    node.right = root.left
    root.left = node

    update_height(node)
    update_height(root)

    return root
  end

  def right_rotation(node)
    root = node.left
    node.left = root.right
    root.right = node

    update_height(node)
    update_height(root)

    return root
  end

  def left_right_rotation(node)
    node.left = left_rotation(node.left)
    right_rotation(node)
  end

  def right_left_rotation(node)
    node.right = right_rotation(node.right)
    left_rotation(node)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  private

  def balance(node)
    if balance_factor(node) > 1 && balance_factor(node.left) >= 0 # LL imbalance
      return right_rotation(node)
    end

    if balance_factor(node) > 1 && balance_factor(node.left) < 0 # LR imbalance
      return left_right_rotation(node)
    end

    if balance_factor(node) < -1 && balance_factor(node.right) <= 0 # RR imbalance
      return left_rotation(node)
    end

    if balance_factor(node) < -1 && balance_factor(node.right) > 0 # RL imbalance
      return right_left_rotation(node)
    end

    return node
  end
end

avl = Avl.new

# Insert values
30.times { |i| avl.insert(i) }

# Print the tree
puts "AVL:"
avl.pretty_print

# Tests delete
avl.delete(25)
avl.delete(23)
avl.delete(24)

# Print the tree
puts "AVL after deleting 23, 24 and 25:"
avl.pretty_print