POSSIBLE_MOVES = [
  [-2, -1], [-2, 1], [2, -1], [2, 1],
  [-1, -2], [-1, 2], [1, -2], [1, 2]
]

def within_bounds?(position) # position = [x, y]
  position.all? { |coord| coord.between?(0, 7) }
end

def knight_moves(start, finish)
  raise "Invalid start position" unless within_bounds?(start)
  raise "Invalid finish position" unless within_bounds?(finish)
  
  board = Array.new(8) { Array.new(8, Float::INFINITY) }
  paths = Array.new(8) { Array.new(8) { [] } }

  board[start[0]][start[1]] = 0
  queue = [start]
  
  until queue.empty?
    current = queue.shift
    POSSIBLE_MOVES.each do |move|
      new_position = [current[0] + move[0], current[1] + move[1]]
      next unless within_bounds?(new_position)
      if board[current[0]][current[1]] + 1 < board[new_position[0]][new_position[1]]
        board[new_position[0]][new_position[1]] = board[current[0]][current[1]] + 1
        paths[new_position[0]][new_position[1]] = paths[current[0]][current[1]] + [current]
        queue << new_position
      end
    end
  end
  
  return paths[finish[0]][finish[1]] + [finish]
end

p knight_moves([0, 0], [3, 3])
p knight_moves([0, 0], [7, 7])
p knight_moves([3, 3], [0, 0])