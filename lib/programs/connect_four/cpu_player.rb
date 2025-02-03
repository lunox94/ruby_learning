require_relative "player"

class CpuPlayer < Player
  def initialize(piece, key = Grid::PLAYER_TWO, name = "CPU")
    super(name, piece, key)
  end

  def choose_column(board)
    available_columns(board).sample
  end

  private

  def available_columns(board)
    board.transpose.map.with_index { |column, index| index if column.include?(nil) }.compact
  end
end