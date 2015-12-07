require "minitest/autorun"
require_relative './instruction_set'

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
