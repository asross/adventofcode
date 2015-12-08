require "minitest/autorun"
require_relative './instruction_set'

class TestInstructionSet < Minitest::Test
  def test_basic_transfer
    instruction_set = InstructionSet.new("1 -> a\na -> b\nb -> c")
    assert_equal instruction_set.evaluate('a'), 1
    assert_equal instruction_set.evaluate('b'), 1
    assert_equal instruction_set.evaluate('c'), 1
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
    assert_equal instruction_set.evaluate('d'), 72
    assert_equal instruction_set.evaluate('e'), 507
    assert_equal instruction_set.evaluate('f'), 492
    assert_equal instruction_set.evaluate('g'), 114
    assert_equal instruction_set.evaluate('h'), 65412
    assert_equal instruction_set.evaluate('i'), 65079
    assert_equal instruction_set.evaluate('x'), 123
    assert_equal instruction_set.evaluate('y'), 456
  end
end
