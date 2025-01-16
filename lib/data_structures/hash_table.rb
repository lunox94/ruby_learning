require_relative 'linked_list'

class HashTable
  include Enumerable
  attr_reader :size

  MIN_CAPACITY = 10

  def initialize
    @size = 0
    @array = Array.new(MIN_CAPACITY) { LinkedList.new }
  end

  def hash(key)
    key.hash % @array.size
  end

  def [](key)
    index = hash(key)
    list = @array[index]
    node = list.find { |n| n.key == key }
    node ? node.value : nil
  end

  def []=(key, value)
    index = hash(key)
    list = @array[index]
    node = list.find { |n| n.key == key }
    
    if node
      node.value = value
    else
      list << KeyValuePair.new(key, value)
      @size += 1
    end
    
    resize(@array.size * 2) if load_factor > 0.75
    
    value
  end

  def delete(key)
    index = hash(key)
    list = @array[index]
    node = list.find { |n| n.key == key }
    
    if node
      list.delete(node)
      @size -= 1
      result = [node.key, node.value]
      resize(@array.size / 2) if load_factor < 0.25 && @array.size > MIN_CAPACITY
      return result
    end
    
    nil
  end

  def each
    @array.each do |list|
      list.each do |node|
        yield [node.key, node.value]
      end
    end
  end

  def to_s
    @array.map { |list| list.to_s }.join(", ")
  end

  private

  def load_factor
    @size.to_f / @array.size
  end

  def resize(capacity)
    old_array = @array
    @array = Array.new(capacity) { LinkedList.new }

    old_array.each do |list|
      list.each do |node|
        @array[hash(node.key)] << node
      end
    end
  end
end

class KeyValuePair
  attr_accessor :key, :value

  def initialize(key, value)
    @key = key
    @value = value
  end

  def to_s
    "#{@key}: #{@value}"
  end
end