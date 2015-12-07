require_relative './bit_value'
require_relative './instruction'

class InstructionSet
  attr_reader :wires

  def initialize(instructions)
    @wires = {}

    @remaining_instructions = instructions.lines.map do |line|
      input_expr, output = line.split(' -> ').map(&:strip)
      inputs = input_expr.scan(/(?:[a-z]+|\d+)/).map do |input|
        @wires[input] ||= BitValue.new(input)
      end
      output = @wires[output] ||= BitValue.new(output)
      operator = input_expr[/RSHIFT|LSHIFT|AND|NOT|OR/]
      Instruction.new(inputs, output, operator)
    end

    execute!
  end

  def execute!
    made_progress = true
    while made_progress
      made_progress = false
      @remaining_instructions.reject! do |i|
        if i.executable?
          i.execute!
          made_progress = true
        end
      end
    end
  end

  def final_value_of(wire_name)
    @wires[wire_name].value
  end
end
