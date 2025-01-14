def sink(arr, root, size)
  left = root * 2 + 1
  right = root * 2 + 2

  largest = root

  if left < size && arr[left] > arr[largest]
    largest = left
  end

  if right < size && arr[right] > arr[largest]
    largest = right
  end

  if root != largest
    arr[root], arr[largest] = arr[largest], arr[root]
    sink(arr, largest, size)
  end
end

def extract(arr, size)
  arr[0], arr[size] = arr[size], arr[0]
  sink(arr, 0, size)
end

def build_max_heap(arr)
  (arr.size / 2 - 1).downto(0) do |node|
    sink(arr, node, arr.size)
  end
end

def heap_sort(arr)
  build_max_heap(arr)

  (arr.size - 1).downto(1) do |i|
    extract(arr, i)
  end
end

arr = [64, 34, 25, 12, 22, 11, 90]

heap_sort(arr)

puts "Sorted array is: #{arr}"