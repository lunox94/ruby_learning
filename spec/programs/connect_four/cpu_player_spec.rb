require "./lib/programs/connect_four/cpu_player"

describe CpuPlayer do
  describe "#choose_column" do
    it "returns a random available column" do
      player = CpuPlayer.new("O")
      board = Array.new(6) { Array.new(7) }
      allow_any_instance_of(Array).to receive(:sample).and_return(3)
      expect(player.choose_column(board)).to eql(3)
    end

    it "returns the only available column" do
      player = CpuPlayer.new("O")
      board = Array.new(6) { Array.new(7) { "X" } }
      random_column = rand(7)
      board[0][random_column] = nil
      expect(player.choose_column(board)).to eql(random_column)
    end
  end
end