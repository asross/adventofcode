require 'minitest/autorun'
require_relative './container_set'

class TestContainerSet < Minitest::Test
  def test_ways_to_fit
    container_set = ContainerSet.new([5])
    assert_equal 1, container_set.ways_to_fit(5)
    assert_equal 0, container_set.ways_to_fit(10)

    container_set = ContainerSet.new([5, 5, 5, 5])
    assert_equal 4, container_set.ways_to_fit(5)
    assert_equal 6, container_set.ways_to_fit(10)
    assert_equal 0, container_set.ways_to_fit(7)

    container_set = ContainerSet.new([20, 15, 10, 5, 5])
    assert_equal 4, container_set.ways_to_fit(25)
  end

  def test_ways_to_most_efficiently_fit
    container_set = ContainerSet.new([20, 15, 10, 5, 5])
    assert_equal 3, container_set.ways_to_most_efficiently_fit(25)
  end
end
