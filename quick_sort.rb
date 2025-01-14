def quick_sort(arr, start_i, end_i)
  if start_i >= end_i
    return
  end

  pivot_i = partition(arr, start_i, end_i)
  quick_sort(arr, start_i, pivot_i - 1)
  quick_sort(arr, pivot_i + 1, end_i)
end

# The partition function is the key to the quick sort algorithm. It finds the pivot and places it in its correct position in the sorted array. It then places all smaller elements to the left of the pivot and all greater elements to the right of the pivot.
def partition(arr, start_i, end_i)
  # i represents the index of the last element that is less than or equal to the pivot
  i = start_i - 1
  # takes the middle element as the pivot (could be any element)
  pivot_i = (start_i + end_i) / 2

  (start_i..end_i).each do |j|
    if arr[j] <= arr[pivot_i] && j != pivot_i
      i += 1
      arr[i], arr[j] = arr[j], arr[i]
    end
  end

  arr[i + 1], arr[pivot_i] = arr[pivot_i], arr[i + 1]
  # now i + 1 is the index of the pivot in the sorted array
  return i + 1
end

arr = [64, 34, 25, 12, 22, 11, 90]

quick_sort(arr, 0, arr.size - 1)

puts "Sorted array is: #{arr}"
