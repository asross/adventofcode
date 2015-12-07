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
