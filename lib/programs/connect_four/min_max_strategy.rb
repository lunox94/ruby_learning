require_relative "grid"

class MinMaxStrategy
  attr_reader :name, :player

  def initialize(depth, player)
    @depth = depth
    @name = "MinMax"
    @player = player
    @transposition_table = {}
  end

  def get_move(board)
    grid = Grid.new(board)

    best_move = nil
    best_score = -Float::INFINITY
    available_columns(grid).each do |move|
      grid.move(move, @player)
      score = minimax(grid, switch_player(@player), @depth - 1, false, -Float::INFINITY, Float::INFINITY)
      grid.undo_move(move)
      
      if score > best_score
        best_score = score
        best_move = move
      end
    end
    best_move
  end

  private

  def minimax(grid, player, depth, maximizing_player, alpha, beta)
    return evaluate(grid, @player) if depth == 0 || grid.game_over?

    # Check the transposition table
    state = grid.state_hash
    if @transposition_table.key?(state) && @transposition_table[state][:depth] >= depth
      return @transposition_table[state][:score]
    end

    if maximizing_player
      best_score = -Float::INFINITY
      available_columns(grid).each do |move|
        grid.move(move, player)
        score = minimax(grid, switch_player(player), depth - 1, false, alpha, beta)
        grid.undo_move(move)
        best_score = [best_score, score].max
        alpha = [alpha, best_score].max
        break if beta <= alpha
      end
      best_score
    else
      best_score = Float::INFINITY
      available_columns(grid).each do |move|
        grid.move(move, player)
        score = minimax(grid, switch_player(player), depth - 1, true, alpha, beta)
        grid.undo_move(move)
        best_score = [best_score, score].min
        beta = [beta, best_score].min
        break if beta <= alpha
      end

      # Store the result in the transposition table
      @transposition_table[state] = { score: best_score, depth: depth }
      best_score
    end
  end

  def available_columns(grid)
    grid.board.first.each_index.select { |col| grid.board.first[col].nil? }
  end

  def switch_player(player)
    player == Grid::PLAYER_ONE ? Grid::PLAYER_TWO : Grid::PLAYER_ONE
  end

  def evaluate(grid, player)
    # Implement a heuristic evaluation function to score the board
    # For example, return a high positive score for a win, a high negative score for a loss, and 0 for a draw
    winner = grid.get_winner

    winner == player ? 100 : winner == switch_player(player) ? -100 : 0
  end
end