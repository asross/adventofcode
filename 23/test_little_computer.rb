require 'minitest/autorun'
require_relative './little_computer'

class LittleComputerTest < Minitest::Test
  def test_little_computer
    lilcomp = LittleComputer.new <<-INSTRUCTIONS
inc a
jio a, +2
tpl a
inc a
    INSTRUCTIONS
    lilcomp.execute!

    assert_equal 2, lilcomp.register_a
    assert_equal 0, lilcomp.register_b
    assert_equal 4, lilcomp.instruction_index
  end
end
