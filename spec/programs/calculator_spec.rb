require "./lib/programs/calculator"

describe Calculator do
  describe "#add" do
    it "returns the sum of two numbers" do
      calc = Calculator.new
      expect(calc.add(5, 10)).to eql(15)
    end

    it "returns the sum of more than two numbers" do
      calc = Calculator.new
      expect(calc.add(5, 10, 15)).to eql(30)
    end
  end

  describe "#subtract" do
    it "returns the difference of two numbers" do
      calc = Calculator.new
      expect(calc.subtract(10, 5)).to eql(5)
    end

    it "returns the difference of more than two numbers" do
      calc = Calculator.new
      expect(calc.subtract(20, 5, 5)).to eql(10)
    end
  end
end