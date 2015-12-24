require 'minitest/autorun'
require_relative './sleigh_balancer'

class SleighBalancerTest < Minitest::Test
  def test_sleigh_balancer
    bal3 = SleighBalancer.new([1,2,3,4,5,7,8,9,10,11], 3)
    assert_equal bal3.best_split.sort, [9, 11]

    bal4 = SleighBalancer.new([1,2,3,4,5,7,8,9,10,11], 4)
    assert_equal bal4.best_split.sort, [4, 11]
  end
end
