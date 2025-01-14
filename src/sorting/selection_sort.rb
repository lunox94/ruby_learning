def selection_sort(arr)
  for i in 0..arr.length - 1
    min = i
    for j in i..arr.length - 1
      if arr[j] < arr[min]
        min = j
      end
    end
    arr[i], arr[min] = arr[min], arr[i]
  end
end

def selection_sort_improved(arr)
  for i in 0..arr.length - 1
    for j in i..arr.length - 1
      if arr[j] < arr[i]
        arr[i], arr[j] = arr[j], arr[i]
      end
    end
  end
end

arr = [64, 34, 25, 12, 22, 11, 90]

selection_sort(arr)

puts "Sorted array is: #{arr}"

arr = [64, 34, 25, 12, 22, 11, 90]

selection_sort_improved(arr)

puts "Sorted array is: #{arr}"