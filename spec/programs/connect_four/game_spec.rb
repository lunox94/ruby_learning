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

  describe "#start" do
      
  end
end

# TODO: start should check when a player chooses an invalid column and request a valid column