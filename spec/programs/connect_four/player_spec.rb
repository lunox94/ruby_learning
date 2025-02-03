require './lib/programs/connect_four/player'

describe Player do
  describe "#initialize" do
    it "creates a player with a name and piece" do
      player = Player.new("Player 1", "X")
      expect(player.name).to eql("Player 1")
      expect(player.piece).to eql("X")
    end
  end

  describe "#choose_column" do
    it "raises an error" do
      player = Player.new("Player 1", "X")
      expect { player.choose_column(nil) }.to raise_error(NotImplementedError)
    end
  end
end