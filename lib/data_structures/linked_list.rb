class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    self.value = value
    self.next_node = next_node
  end
end

class LinkedList
  include Enumerable
  attr_accessor :head, :size

  def initialize
    self.head = nil
    self.size = 0
  end

  def append(value)
    new_node = Node.new(value)

    if empty?
      self.head = new_node
    else
      ref = head
      ref = ref.next_node while ref.next_node
      ref.next_node = new_node
    end

    self.size += 1
    return value
  end

  def clear
    self.head = nil
    self.size = 0
  end

  def each
    ref = head
    while ref
      yield ref.value
      ref = ref.next_node
    end
  end

  def delete(value)
    raise "List is empty" if empty?

    if head.value == value
      self.head = head.next_node
      self.size -= 1
      return value
    end

    ref = head
    prev = nil

    until ref.nil? || ref.value == value
      prev = ref
      ref = ref.next_node
    end

    if ref.nil?
      return nil
    end

    prev.next_node = ref.next_node
    self.size -= 1
    return value
  end

  def empty?
    head.nil?
  end

  def reverse
    prev = nil
    current = head
    while current
      next_node = current.next_node
      current.next_node = prev
      prev = current
      current = next_node
    end
    self.head = prev
  end

  def shift(value)
    new_node = Node.new(value, head)
    self.head = new_node
    self.size += 1
    return value
  end

  def to_s
    return "[]" if empty?
    elements = []
    each { |i| elements << i }
    "[#{elements.join(' -> ')}]"
  end

  def [](index)
    return nil if index < 0 || index >= size
    ref = head
    index.times { ref = ref.next_node }
    ref.value
  end

  def <<(value)
    append(value)
  end
end