require "./lib/data_structures/array_based_stack"

describe Stack do
  let(:stack) { Stack.new }

  it "is empty" do
    expect(stack.empty?).to be true
  end

  it "is not empty" do
    stack.push(5)

    expect(stack.empty?).to be false
  end

  it "pushes elements" do
    stack.push(5)
    stack.push(6)
    stack.push(0)

    expect(stack.to_s).to eq("[5, 6, 0]")
  end

  it "pops elements" do
    stack.push(5)
    stack.push(6)
    stack.push(0)

    expect(stack.pop).to eq(0)
    expect(stack.pop).to eq(6)
  end

  it "pushes elements after popping" do
    stack.push(5)
    stack.push(6)
    stack.push(0)
    stack.pop
    stack.pop
    stack.push(25)

    expect(stack.to_s).to eq("[5, 25]")
  end

  it "shows the top element" do
    stack.push(5)
    stack.push(6)
    stack.push(0)
    
    stack.pop

    expect(stack.peek).to eq(6)
  end
end