require_relative "grid"
require_relative "player"
require_relative "human_player"
require_relative "cpu_player"

class Game
  attr_reader :grid, :current_player

  def initialize
    @players = [HumanPlayer.new("Player 1", "🔵"), CpuPlayer.new("🔴")]
    @grid = Grid.new
  end
  
  def start
    @current_player = @players.first

    until @grid.full? || @grid.winner?
      display_grid
      column = @current_player.choose_column @grid.board
      @grid.move(column, @current_player.key)
      swap_players
    end

    display_grid
    if @grid.winner?
      winner = @current_player == @players.first ? @players.last : @players.first
      puts "Congratulations, #{winner.name}! You win!"
    else
      puts "It's a draw!"
    end
  end

  def players
    @players.dup
  end

  private

  def display_grid
    system "clear" or system "cls"
    mapped_grid = @grid.board.map { |row| row.map { |cell| cell.nil? ? "⚪️" : cell == Grid::PLAYER_ONE ? players[0].piece : players[1].piece }.join(" ") }
    mapped_grid = mapped_grid.map { |row| ["┃", row, "┃"].join(" ") }
    puts mapped_grid
    puts "┗━━━━━━━━━━━━━━━━━━━━━━┛"
    puts "  0  1  2  3  4  5  6"
  end

  def swap_players
    @current_player = @current_player == @players.first ? @players.last : @players.first
  end
end