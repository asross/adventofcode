class LittleComputer
  attr_reader :instruction_index, :register_a, :register_b

  def initialize(instructions)
    @register_a = 0
    @register_b = 0
    @instruction_index = 0
    @instructions = instructions.lines.map { |line| line.split(/,?\s/) }
  end

  def get(register)
    instance_variable_get(:"@register_#{register}")
  end

  def set(register, value)
    instance_variable_set(:"@register_#{register}", value)
  end

  def execute!
    while (0..@instructions.length-1).include?(@instruction_index)
      send(*@instructions[@instruction_index])
    end
  end

  def inc(register)
    set(register, get(register)+1)
    @instruction_index += 1
  end

  def hlf(register)
    set(register, get(register)/2)
    @instruction_index += 1
  end

  def tpl(register)
    set(register, get(register)*3)
    @instruction_index += 1
  end

  def jmp(offset)
    @instruction_index += offset.to_i
  end

  def jie(register, offset)
    if get(register) % 2 == 0
      jmp(offset)
    else
      @instruction_index += 1
    end
  end

  def jio(register, offset)
    if get(register) == 1
      jmp(offset)
    else
      @instruction_index += 1
    end
  end
end
