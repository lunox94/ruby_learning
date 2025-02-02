require './lib/programs/connect_four/grid'

describe Grid do
  describe "#board" do
    it "returns a 6x7 grid" do
      grid = Grid.new
      expect(grid.board.size).to eql(6)
      expect(grid.board.all? { |row| row.size == 7 }).to eql(true)
    end

    it "returns a grid with all nil values" do
      grid = Grid.new
      expect(grid.board.all? { |row| row.all? { |cell| cell.nil? } }).to eql(true)
    end

    it "returns a copy of the grid" do
      grid = Grid.new
      grid.board[0][0] = Grid::PLAYER_ONE
      expect(grid.board[0][0]).to eql(nil)
    end
  end

  describe "#move" do
    it "places a piece in the specified column" do
      grid = Grid.new
      grid.move(0, Grid::PLAYER_ONE)
      expect(grid.board[5][0]).to eql(Grid::PLAYER_ONE)
    end

    it "places a piece on top of another piece" do
      grid = Grid.new
      grid.move(0, Grid::PLAYER_ONE)
      grid.move(0, Grid::PLAYER_TWO)
      expect(grid.board[5][0]).to eql(Grid::PLAYER_ONE)
      expect(grid.board[4][0]).to eql(Grid::PLAYER_TWO)
    end

    it "raises an error if the column is full" do
      grid = Grid.new
      6.times { grid.move(0, Grid::PLAYER_ONE) }
      expect { grid.move(0, Grid::PLAYER_ONE) }.to raise_error("Column is full")
    end

    it "raises an error if the player is invalid" do
      grid = Grid.new
      expect { grid.move(0, "Invalid") }.to raise_error("Invalid player")
    end
  end

  describe "full?" do
    it "returns false if the grid is not full" do
      grid = Grid.new
      expect(grid.full?).to eql(false)
    end

    it "returns true if the grid is full" do
      grid = Grid.new
      7.times do |col|
        6.times { grid.move(col, Grid::PLAYER_ONE) }
      end
      expect(grid.full?).to eql(true)
    end
  end
  
  describe "winner?" do
    it "returns false if there is no winner" do
      grid = Grid.new
      expect(grid.winner?).to eql(false)
    end

    it "returns true if there is a winner in a column" do
      grid = Grid.new
      4.times { grid.move(0, Grid::PLAYER_ONE) }
      expect(grid.winner?).to eql(true)
    end

    it "returns true if there is a winner in a row" do
      grid = Grid.new
      4.times { |col| grid.move(col, Grid::PLAYER_ONE) }
      expect(grid.winner?).to eql(true)
    end

    it "returns true if there is a winner in a diagonal" do
      grid = Grid.new

      3.times { grid.move(0, Grid::PLAYER_ONE) }
      grid.move(0, Grid::PLAYER_TWO)

      2.times { grid.move(1, Grid::PLAYER_ONE) }
      grid.move(1, Grid::PLAYER_TWO)

      grid.move(2, Grid::PLAYER_ONE)
      grid.move(2, Grid::PLAYER_TWO)

      grid.move(3, Grid::PLAYER_TWO)

      expect(grid.winner?).to eql(true)
    end
  end
end