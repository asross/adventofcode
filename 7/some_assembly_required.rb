#--- Day 7: Some Assembly Required ---

#This year, Santa brought little Bobby Tables a set of wires and bitwise logic gates! Unfortunately, little Bobby is a little under the recommended age range, and he needs help assembling the circuit.

#Each wire has an identifier (some lowercase letters) and can carry a 16-bit signal (a number from 0 to 65535). A signal is provided to each wire by a gate, another wire, or some specific value. Each wire can only get a signal from one source, but can provide its signal to multiple destinations. A gate provides no signal until all of its inputs have a signal.

#The included instructions booklet describe how to connect the parts together: x AND y -> z means to connect wires x and y to an AND gate, and then connect its output to wire z.

#For example:

#123 -> x means that the signal 123 is provided to wire x.
#x AND y -> z means that the bitwise AND of wire x and wire y is provided to wire z.
#p LSHIFT 2 -> q means that the value from wire p is left-shifted by 2 and then provided to wire q.
#NOT e -> f means that the bitwise complement of the value from wire e is provided to wire f.
#Other possible gates include OR (bitwise OR) and RSHIFT (right-shift). If, for some reason, you'd like to emulate the circuit instead, almost all programming languages (for example, C, JavaScript, or Python) provide operators for these gates.

#For example, here is a simple circuit:

#123 -> x
#456 -> y
#x AND y -> d
#x OR y -> e
#x LSHIFT 2 -> f
#y RSHIFT 2 -> g
#NOT x -> h
#NOT y -> i
#After it is run, these are the signals on the wires:

#d: 72
#e: 507
#f: 492
#g: 114
#h: 65412
#i: 65079
#x: 123
#y: 456
#In little Bobby's kit's instructions booklet (provided as your puzzle input), what signal is ultimately provided to wire a?

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

class Instruction
  def initialize(inputs, output, operator)
    raise ArgumentError if operator.nil? && inputs.length > 1
    @inputs = inputs
    @output = output
    @operator = (operator || 'value').downcase.to_sym
  end

  def executable?
    @inputs.all?(&:defined?)
  end

  def execute!
    @output.value = @inputs.first.send(@operator, *@inputs[1..-1])
  end
end

class InstructionSet
  attr_reader :wires

  def initialize(instructions)
    @wires = {}

    @remaining_instructions = instructions.lines.map do |line|
      input_expr, output_expr = line.split(' -> ').map(&:strip)
      inputs = input_expr.scan(/(?:[a-z]+|\d+)/).map do |input|
        @wires[input] ||= BitValue.new(input)
      end
      output = @wires[output_expr] ||= BitValue.new(output_expr)
      operator = input_expr[/RSHIFT|LSHIFT|AND|NOT|OR/]
      Instruction.new(inputs, output, operator)
    end

    execute!
  end

  def execute!
    while @remaining_instructions.any?(&:executable?)
      @remaining_instructions.reject! do |i|
        if i.executable?
          i.execute!; true
        end
      end
    end
  end

  def final_value_of(wire_name)
    @wires[wire_name].value
  end
end

require "minitest/autorun"

class TestInstructionSet < Minitest::Test
  def test_basic_transfer
    instruction_set = InstructionSet.new("1 -> a\na -> b\nb -> c")
    assert_equal instruction_set.final_value_of('a'), 1
    assert_equal instruction_set.final_value_of('b'), 1
    assert_equal instruction_set.final_value_of('c'), 1
  end

  def test_operators
    instruction_set = InstructionSet.new <<-INSTRUCTIONS
123 -> x
456 -> y
x AND y -> d
x OR y -> e
x LSHIFT 2 -> f
y RSHIFT 2 -> g
NOT x -> h
NOT y -> i
    INSTRUCTIONS
    assert_equal instruction_set.final_value_of('d'), 72
    assert_equal instruction_set.final_value_of('e'), 507
    assert_equal instruction_set.final_value_of('f'), 492
    assert_equal instruction_set.final_value_of('g'), 114
    assert_equal instruction_set.final_value_of('h'), 65412
    assert_equal instruction_set.final_value_of('i'), 65079
    assert_equal instruction_set.final_value_of('x'), 123
    assert_equal instruction_set.final_value_of('y'), 456
  end
end

main_set = InstructionSet.new(File.read('./instructions'))
puts main_set.final_value_of('a')
