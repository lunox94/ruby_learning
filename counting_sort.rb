def counting_sort!(arr)
    min = arr.min
    max = arr.max
    range = max - min + 1
    count = Array.new(range, 0)

    for i in 0...arr.size
      count[arr[i] - min] += 1
    end

    for i in 1...count.size
      count[i] += count[i - 1]
    end

    output = Array.new(arr.size, 0)
    
    (arr.size - 1).downto(0) do |i|
      value = arr[i]
      position = count[value - min] - 1
      output[position] = value
      count[value - min] -= 1
    end

    arr.replace(output)
end

arr = [64, 34, 25, 12, 22, 11, 90, 12]

counting_sort!(arr)

puts "Sorted array is: #{arr}"