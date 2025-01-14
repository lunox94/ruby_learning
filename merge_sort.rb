# Merge Sort is a *divide and conquer* algorithm that divides a list into equal halves until it has two single elements and then merges the sub-lists until the entire list has been reassembled in order.

def merge_sort(arr)
  if arr.length <= 1
    return arr
  end

  mid = arr.length / 2
  left = arr[0...mid]
  right = arr[mid..-1]

  merge(merge_sort(left), merge_sort(right))
end

def merge(left, right)
  result = []
  until left.empty? || right.empty?
    result << (left.first <= right.first ? left.shift : right.shift)
  end
  result + left + right
end

arr = [64, 34, 25, 12, 22, 11, 90]

arr = merge_sort(arr)

puts "Sorted array is: #{arr}"