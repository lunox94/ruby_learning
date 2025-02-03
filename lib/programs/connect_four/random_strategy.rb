class RandomStrategy
  attr_reader :name

  def initialize
    @name = "Random"
  end

  def get_move(board)
    available_columns(board).sample
  end

  def to_s
    @name
  end

  private 

  def available_columns(board)
    board.transpose.map.with_index { |column, index| index if column.include?(nil) }.compact
  end
end