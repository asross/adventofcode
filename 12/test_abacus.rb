require 'minitest/autorun'
require_relative './abacus'

class TestAbacus < Minitest::Test
  def test_abacus
    assert_equal 6, sum_across([1,2,3])
    assert_equal 3, sum_across(JSON.parse('{"a":{"b":4},"c":-1}'))
    assert_equal 0, sum_across(JSON.parse('[-1,{"a":1}]'))
    assert_equal 0, sum_across([])
  end

  def test_ignore_red
    assert_equal 4, sum_across(JSON.parse('[1,{"c":"red","b":2},3]'), true)
  end
end
