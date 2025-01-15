class Stack
  def initialize
    @array = Array.new(1)
    @top = -1
  end

  def empty?
    @top == -1
  end

  def peek
    empty? ? nil : @array[@top]
  end

  def pop
    if empty?
      return nil
    else
      @top -= 1
      return @array[@top+1]
    end
  end

  def push(element)
    @top += 1

    unless @top < @array.size
      expand
    end
    
    @array[@top] = element
  end

  def to_s
    @array[0..@top].to_s
  end

  private

  def expand
    new_array = Array.new(@array.size * 2)
    
    @array.each_with_index { |item, index| new_array[index] = item }

    @array = new_array
  end
end