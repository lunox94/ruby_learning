def insertion_sort(arr)
  for i in 1..arr.length - 1
    j = i - 1
    while j >= 0 && arr[j] > arr[j + 1]
      arr[j], arr[j + 1] = arr[j + 1], arr[j]
      j -= 1
    end
  end
end

arr = [64, 34, 25, 12, 22, 11, 90]

insertion_sort(arr)

puts "Sorted array is: #{arr}"