class Player
  attr_reader :name, :piece, :key

  def initialize(name, piece, key = Grid::PLAYER_ONE)
    @name = name
    @piece = piece
    raise "Invalid key" unless [Grid::PLAYER_ONE, Grid::PLAYER_TWO].include?(key)
    @key = key
  end

  def choose_column(board)
    raise NotImplementedError, "Subclasses must implement the choose_column method"
  end
end