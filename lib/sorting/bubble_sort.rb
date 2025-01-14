def bubble_sort(arr)
  for i in 0..arr.length - 1
    for j in 0..arr.length - i - 2
      if arr[j] > arr[j + 1]
        arr[j], arr[j + 1] = arr[j + 1], arr[j]
      end
    end
  end
end

arr = [64, 34, 25, 12, 22, 11, 90]

bubble_sort(arr)

puts "Sorted array is: #{arr}"