def shell_sort(arr)
  gap = arr.size / 2

  while gap > 0
    for i in gap..arr.size - 1
      j = i - gap
      while j >= 0 && arr[j] > arr[j + gap]
        arr[j], arr[j + gap] = arr[j + gap], arr[j]
        j -= gap
      end
    end

    gap /= 2
  end
end

arr = [64, 34, 25, 12, 22, 11, 90]

shell_sort(arr)

puts "Sorted array is: #{arr}"