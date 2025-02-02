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
    it "returns the column chosen by the player" do
      player = Player.new("Player 1", "X")
      allow(player).to receive(:print).and_return(nil)
      allow(player).to receive(:gets).and_return("3\n")
      expect(player.choose_column).to eql(3)
    end

    it "repeats the prompt if the player chooses an invalid column" do
      player = Player.new("Player 1", "X")
      allow(player).to receive(:print).and_return(nil)
      allow(player).to receive(:gets).and_return("7\n", "3\n")
      expect(player).to receive(:puts).with("Invalid column. Please choose a column between 0 and 6.")
      player.choose_column
    end
  end
end