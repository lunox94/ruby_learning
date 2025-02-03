require_relative "player"
require_relative "random_strategy"

class CpuPlayer < Player
  def initialize(piece, strategy = RandomStrategy.new, key = Grid::PLAYER_TWO, name = "CPU")
    super(name, piece, key)
    @strategy = strategy
  end

  def choose_column(board)
    @strategy.get_move(board)
  end
end