class Player
  attr_reader :name, :piece, :key

  def initialize(name, piece, key = Grid::PLAYER_ONE)
    @name = name
    @piece = piece
    raise "Invalid key" unless [Grid::PLAYER_ONE, Grid::PLAYER_TWO].include?(key)
    @key = key
  end

  def choose_column
    loop do
      print "#{@name}, choose a column (0-6): "
      column = gets.chomp.to_i
      return column if (0..6).include?(column)
      puts "Invalid column. Please choose a column between 0 and 6."
    end
  end
end