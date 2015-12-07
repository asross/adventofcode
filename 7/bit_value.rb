class BitValue
  attr_accessor :value, :name

  def initialize(input = nil)
    if input =~ /\d+/
      @value = input.to_i
    else
      @name = input
    end
  end

  def defined?
    !!value
  end

  def and(other)
    value & other.value
  end

  def or(other)
    value | other.value
  end

  def rshift(other)
    value >> other.value
  end

  def lshift(other)
    value << other.value
  end

  def not
    15.downto(0).map { |n| (~value)[n] }.join.to_i(2)
  end
end
