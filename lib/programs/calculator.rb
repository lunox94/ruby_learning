class Calculator
  def add(*args)
    args.inject(0) { |sum, arg| sum + arg }
  end

  def subtract(*args)
    args.inject { |diff, arg| diff - arg }
  end
end