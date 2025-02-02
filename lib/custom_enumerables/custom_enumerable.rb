module Enumerable
  def my_each
    for e in self
      yield e
    end
  end

  def my_find
    self.my_each { |e| return e if yield(e) }
    nil
  end

  def my_map
    new_array = []
    self.my_each { |e| new_array << yield(e) }
    new_array
  end

  def my_each_with_index
    index = 0
    self.my_each do |e|
      yield e, index
      index += 1
    end
  end

  def my_select
    new_array = []
    self.my_each { |e| new_array << e if yield(e) }
    new_array
  end

  def my_all?
    self.my_each { |e| return false unless yield(e) }
    true
  end

  def my_any?
    self.my_each { |e| return true if yield(e) }
    false
  end

  def my_none?
    self.my_each { |e| return false if yield(e) }
    true
  end

  def my_count?
    return self.size unless block_given?
    count = 0
    self.my_each { |e| count += 1 if yield(e) }
    count
  end

  def my_inject(initial = nil)
    accumulator = initial || self.first
    self.my_each_with_index do |e, i|
      next if i == 0 && initial.nil?
      accumulator = yield(accumulator, e)
    end
    accumulator
  end
end

a = [1, 2, 3, 4, 5]

puts a.my_find { |e| e > 3 } # => 4
p a.my_map { |e| e * 2 } # => [2, 4, 6, 8, 10]
a.my_each_with_index { |e, i| puts "Element: #{e}, Index: #{i}" }
p a.my_select &:even? # => [2, 4]
puts a.my_all? { |e| e > 0 } # => true
puts a.my_all? { |e| e > 3 } # => false
puts a.my_any? { |e| e > 3 } # => true
puts a.my_any? { |e| e > 5 } # => false
puts a.my_none? { |e| e > 5 } # => true
puts a.my_none? { |e| e > 3 } # => false
puts a.my_count? { |e| e > 3 } # => 2
puts a.my_count? # => 5
puts a.my_inject { |acc, e| acc + e } # => 15
puts a.my_inject(10) { |acc, e| acc + e } # => 25
puts a.my_inject(&:*) # => 120