require './lib/data_structures/linked_list'

describe LinkedList do
  let(:linked_list) { LinkedList.new }

  it "is empty" do
    expect(linked_list.empty?).to be true
  end

  it "is not empty" do
    linked_list.append(5)
    expect(linked_list.empty?).to be false
  end

  it "appends elements" do
    linked_list.append(5)
    linked_list.append(6)
    linked_list.append(0)

    expect(linked_list.to_s).to eq("[5 -> 6 -> 0]")
  end

  it "prepends elements" do
    linked_list.shift(5)
    linked_list.shift(6)
    linked_list.shift(0)

    expect(linked_list.to_s).to eq("[0 -> 6 -> 5]")
  end

  it "deletes elements" do
    linked_list.append(5)
    linked_list.append(6)
    linked_list.append(0)
    linked_list.delete(6)

    expect(linked_list.to_s).to eq("[5 -> 0]")
  end

  it "reverses the list" do
    linked_list.append(5)
    linked_list.append(6)
    linked_list.append(0)
    linked_list.reverse

    expect(linked_list.to_s).to eq("[0 -> 6 -> 5]")
  end

  it "returns an element by index" do
    linked_list.append(5)
    linked_list.append(6)
    linked_list.append(0)

    expect(linked_list[1]).to eq(6)
  end

  it "returns nil for an invalid index" do
    linked_list.append(5)
    linked_list.append(6)
    linked_list.append(0)

    expect(linked_list[3]).to be nil
  end

  it "clears the list" do
    linked_list.append(5)
    linked_list.append(6)
    linked_list.append(0)
    linked_list.clear

    expect(linked_list.empty?).to be true
  end

  it "iterates over the list" do
    linked_list.append(5)
    linked_list.append(6)
    linked_list.append(0)

    elements = []
    linked_list.each { |i| elements << i }

    expect(elements).to eq([5, 6, 0])
  end

  it "overloads the << operator" do
    linked_list << 5
    linked_list << 6
    linked_list << 0

    expect(linked_list.to_s).to eq("[5 -> 6 -> 0]")
  end

  it "raises an error when deleting from an empty list" do
    expect { linked_list.delete(5) }.to raise_error("List is empty")
  end
end