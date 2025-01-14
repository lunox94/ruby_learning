def radix_sort(arr)
  max = arr.max
  number_of_digits = max.to_s.length

  0.upto(number_of_digits - 1) do |position|
    buckets = Array.new(10) { Array.new(0) }

    arr.each do |i|
      digit = (i / 10 ** position) % 10
      buckets[digit].push(i)
    end

    arr.replace(buckets.flatten)
  end
end

arr = [64, 34, 25, 12, 22, 11, 90, 12]

radix_sort(arr)

puts "Sorted array is: #{arr}"