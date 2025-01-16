class CircularQueue
  attr_reader :size

  def initialize
    @array = Array.new(3)
    @back = -1
    @front = 0
    @size = 0
  end

  def dequeue
    return nil if empty?
    value = @array[@front]
    @front = (@front + 1) % @array.size
    @size -= 1
    return value
  end

  def empty?
    @size == 0
  end

  def enqueue(value)
    expand if full?
    @size += 1
    @back = (@back + 1) % @array.size
    @array[@back % @array.size] = value
  end

  def to_s
    elements = []
    @size.times { |i| elements << @array[(@front + i) % @array.size] }
    "[#{elements.join(', ')}]"
  end

  def peek
    empty? ? nil : @array[@front]
  end

  private

  def expand
    new_array = Array.new(@array.size * 2, nil)
    (0...@array.size).each do |i|
      new_array[i] = @array[(@front + i) % @array.size]
    end
    @front = 0
    @back = @array.size - 1
    @array = new_array
  end

  def full?
    @size == @array.size
  end
end