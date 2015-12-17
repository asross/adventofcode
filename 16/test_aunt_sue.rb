require 'minitest/autorun'
require_relative './aunt_sue'

class TestAuntSue < Minitest::Test
  def test_criteria
    exact_criteria = ExactAuntCriteria.new("children: 1\ncats:2")
    fuzzy_criteria = FuzzyAuntCriteria.new("children: 1\ncats:2")
    assert_equal true, exact_criteria.accepts?('chickens', 0)
    assert_equal true, exact_criteria.accepts?('children', 1)
    assert_equal false, exact_criteria.accepts?('children', 2)
    assert_equal true, fuzzy_criteria.accepts?('chickens', 0)
    assert_equal false, fuzzy_criteria.accepts?('cats', 1)
    assert_equal false, fuzzy_criteria.accepts?('cats', 2)
    assert_equal true, fuzzy_criteria.accepts?('cats', 3)
  end

  def test_aunt_sue
    aunt_sue = AuntSue.new("Sue 1: children: 1, cats: 2")
    assert_equal 1, aunt_sue.number
    assert_equal({ 'children' => 1, 'cats' => 2 }, aunt_sue.attributes)

    assert_equal true, aunt_sue.matches?(ExactAuntCriteria.new("children: 1\ncats:2\ngoldfish: 3"))
    assert_equal false, aunt_sue.matches?(ExactAuntCriteria.new("children: 1\ncats:1"))
  end
end
