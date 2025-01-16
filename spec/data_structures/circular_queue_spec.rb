require './lib/data_structures/circular_queue'

describe CircularQueue do
  let(:queue) { CircularQueue.new }

  it "is empty" do
    expect(queue.empty?).to be true
  end

  it "is not empty" do
    queue.enqueue(5)
    expect(queue.empty?).to be false
  end

  it "enqueues elements" do
    queue.enqueue(5)
    queue.enqueue(6)
    queue.enqueue(0)

    expect(queue.to_s).to eq("[5, 6, 0]")
  end

  it "dequeues elements" do
    queue.enqueue(5)
    queue.enqueue(6)

    expect(queue.dequeue).to eq(5)
    expect(queue.dequeue).to eq(6)
    expect(queue.empty?).to be true
  end

  it "peek at the front element" do
    queue.enqueue(5)
    queue.enqueue(6)

    expect(queue.peek).to eq(5)
  end

  it "expands the queue" do
    100.times { |i| queue.enqueue(i) }

    expect(queue.size).to eq(100)
  end
end