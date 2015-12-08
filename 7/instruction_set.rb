class InstructionSet
  OPERATORS = { 'OR' => :|, 'AND' => :&, 'RSHIFT' => :>>, 'LSHIFT' => :<< }

  def sanitize(input)
    input = input.strip
    return input.to_i if input =~ /\d+/
    OPERATORS.each { |op, sym| return sym if input == op }
    input
  end

  def initialize(instructions)
    @wires = instructions.lines.each_with_object({}) do |line, h|
      input_expr, output = line.split(' -> ').map(&:strip)
      h[output] = input_expr.split.map(&method(:sanitize))
    end
  end

  def evaluate(v)
    return v if v.is_a?(Fixnum)
    e = @wires[v]
    return e if e.is_a?(Fixnum)
    @wires[v] = case e.length
    when 1
      evaluate(e.first)
    when 2
      r = evaluate(e.last)
      15.downto(0).map { |n| (~r)[n] }.join.to_i(2)
    when 3
      v1, operator, v2 = e
      evaluate(v1).send(operator, evaluate(v2))
    end
  end
end
