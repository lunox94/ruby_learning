class Player
  attr_reader :name, :piece, :key

  def initialize(name, piece, key = Grid::PLAYER_ONE)
    @name = name
    @piece = piece
    raise "Invalid key" unless [Grid::PLAYER_ONE, Grid::PLAYER_TWO].include?(key)
    @key = key
  end

  def choose_column(board)
    loop do
      column = prompt_for_column
      
      unless (0..6).include?(column)
        puts "Invalid column. Please choose a column between 0 and 6."
        next
      end

      puts "Column is full. Please choose another column." if board.transpose[column].none?(&:nil?)
      return column if (0..6).include?(column) && board.transpose[column].any?(&:nil?)
    end
  end

  private

  def prompt_for_column
    print "#{@name}, choose a column (0-6): "
    gets.chomp.to_i
  end
end