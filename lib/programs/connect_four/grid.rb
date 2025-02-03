class Grid
  PLAYER_ONE = true
  PLAYER_TWO = false
  COLUMN_FULL_ERROR = "Column is full"

  def initialize
    @board = Array.new(6) { Array.new(7) }
  end

  def board
    @board.map(&:dup)
  end

  def move(col, player)
    raise "Invalid player" unless [PLAYER_ONE, PLAYER_TWO].include?(player)
    nil_count = @board.transpose[col].count(&:nil?)
    raise COLUMN_FULL_ERROR if nil_count.zero?

    row = nil_count - 1
    @board[row][col] = player
  end

  def full?
    @board.all? { |row| row.none?(&:nil?) }
  end

  def winner?
    return true if winning_combination?(@board.transpose) # Check columns
    return true if winning_combination?(@board)           # Check rows
    return true if winning_combination?(diagonals)        # Check diagonals

    false # No winner
  end

  private

  def diagonals
    diagonals = []

    (0..2).each do |i|
      # Collect diagonals from top-left to bottom-right
      diagonals << (0..5-i).map { |j| @board[i + j][j] }
      diagonals << (0..5-i).map { |j| @board[i + j][6 - j] }

      # Collect diagonals from bottom-left to top-right
      diagonals << (0..5-i).map { |j| @board[5 - j][j] }
      diagonals << (0..5-i).map { |j| @board[5 - j][6 - j] }
    end
    
    diagonals
  end

  def winning_combination?(lines)
    lines.each do |line|
      line.each_cons(4) do |four|
        return true if four.all? { |cell| cell == four.first && !cell.nil? }
      end
    end
    false
  end
end