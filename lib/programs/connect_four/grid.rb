class Grid
  PLAYER_ONE = true
  PLAYER_TWO = false
  COLUMN_FULL_ERROR = "Column is full"

  def initialize(board = nil)
    @board = board || Array.new(6) { Array.new(7) }
    @zobrist_table = Array.new(6) { Array.new(7) { Array.new(2) { rand(2**64) } } }
  end

  def board
    @board.map(&:dup)
  end

  def move(col, player)
    raise "Invalid player" unless [PLAYER_ONE, PLAYER_TWO].include?(player)

    # Find the lowest available row in the column
    (board.length - 1).downto(0) do |row|
      if @board[row][col].nil?
        @board[row][col] = player
        return
      end
    end

    raise COLUMN_FULL_ERROR
  end

  def undo_move(col)
    (0..5).each do |row|
      unless @board[row][col].nil?
        @board[row][col] = nil
        break
      end
    end
  end

  def full?
    @board.all? { |row| row.none?(&:nil?) }
  end

  def winner?
    !get_winner.nil?
  end

  def get_winner
    winner = winning_combination?(@board.transpose)
    return winner unless winner.nil?

    winner = winning_combination?(@board)
    return winner unless winner.nil?

    winner = winning_combination?(diagonals)
    return winner unless winner.nil?

    nil
  end

  def game_over?
    full? || winner?
  end

  def state_hash
    hash = 0
    @board.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        next if cell.nil?
        player_index = cell == PLAYER_ONE ? 0 : 1
        hash ^= @zobrist_table[i][j][player_index]
      end
    end
    hash
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
        return four.first if four.all? { |cell| cell == four.first && !cell.nil? }
      end
    end
    nil
  end
end