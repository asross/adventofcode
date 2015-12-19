require 'minitest/autorun'
require_relative './replacement_machine'

class TestReplacementMachine < Minitest::Test
  def test_replacements_for
    machine = ReplacementMachine.new("H => HO\nH => OH\nO => HH")
    assert_equal Set.new(%w(HOOH HOHO OHOH HHHH)), machine.replacements_for("HOH")
  end

  def test_multiple_characters
    machine = ReplacementMachine.new("ab => HO\nbc => OH")
    assert_equal Set.new(%w(HOc aOH)), machine.replacements_for("abc")
  end

  def test_shortest_path
    machine = ReplacementMachine.new("e => H\ne => O\nH => HO\nH => OH\nO => HH")
    hoh_path = machine.shortest_path_to("HOH")
    hohoho_path = machine.shortest_path_to("HOHOHO")
    assert_equal 3, hoh_path.length-1
    assert_equal 6, hohoho_path.length-1
  end
end
