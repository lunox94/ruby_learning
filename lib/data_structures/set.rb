require_relative 'hash_table' # HashTable is used to store the elements of the set

class MySet
  include Enumerable

  def initialize
    @hash = HashTable.new
  end

  def add(element)
    unless contains?(element)
      @hash[element] = element
    end
  end

  def contains?(element)
    @hash[element] != nil
  end
  
  def difference(other_set)
    new_set = MySet.new
    self.each { |e| new_set.add(e) unless other_set.contains?(e) }
    
    new_set
  end

  def each
    @hash.each { |key, _| yield key }
  end

  def intersection(other_set)
    new_set = MySet.new
    self.each do |e|
      new_set.add(e) if other_set.contains?(e)
    end
    
    new_set
  end

  def remove(element)
    @hash.delete(element) if contains?(element)
  end

  def size
    @hash.size
  end
  
  def subset?(other_set)
    self.each do |e|
      return false unless other_set.contains?(e)
    end

    true
  end

  def to_s
    "[#{self.reduce([]) { |acc, cur| acc << cur }.join(', ')}]"
  end
  
  def union(other_set)
    new_set = MySet.new
    self.each { |e| new_set.add(e) }
    other_set.each { |e| new_set.add(e) }
    
    new_set
  end
end