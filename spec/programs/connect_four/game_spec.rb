require './lib/programs/connect_four/game'

describe Game do
  describe "#initialize" do
    it "creates a new game with two players" do
      game = Game.new
      expect(game.players.size).to eql(2)
    end

    it "creates a new game with a grid" do
      game = Game.new
      expect(game.grid).to be_instance_of(Grid)
    end
  end

  describe "#players" do
    it "returns a duplicate of the players array" do
      game = Game.new
      players = game.players
      players.pop
      expect(game.players.size).to eql(2)
    end
  end

  describe "#start" do
    it "requests a column from the current player" do
      game = Game.new
      
      allow(game).to receive(:display_grid).and_return(nil)
      allow(game.grid).to receive(:full?).and_return(false, true)
      allow(game.grid).to receive(:winner?).and_return(false, true)
      allow(game).to receive(:puts).and_return(nil) # Prevents puts from printing to the console
      
      expect(game.players.first).to receive(:choose_column).with(game.grid.board).and_return(0)
      
      game.start
    end

    it "displays the grid" do
      game = Game.new
      
      allow(game.grid).to receive(:full?).and_return(false, false)
      allow(game.grid).to receive(:winner?).and_return(false, true)
      allow(game).to receive(:puts).and_return(nil) # Prevents puts from printing to the console
      allow(game.players.first).to receive(:choose_column).and_return(0) # Mocks the player's choice
      
      expect(game).to receive(:display_grid).twice
      
      game.start
    end

    it "stops the game when there is a winner" do
      game = Game.new
      
      allow(game).to receive(:display_grid).and_return(nil)
      allow(game.grid).to receive(:full?).and_return(false, false)
      allow(game.grid).to receive(:winner?).and_return(false, true)
      allow(game.players.first).to receive(:choose_column).and_return(0) # Mocks the player's choice
      
      expect(game).to receive(:puts).with("Congratulations, Player 1! You win!")
      game.start
    end

    it "stops the game when there is a draw" do
      game = Game.new
      
      allow(game).to receive(:display_grid).and_return(nil)
      allow(game.grid).to receive(:full?).and_return(false, true)
      allow(game.grid).to receive(:winner?).and_return(false, false)
      allow(game.players.first).to receive(:choose_column).and_return(0) # Mocks the player's choice
      
      expect(game).to receive(:puts).with("It's a draw!")
      game.start
    end
  end
end