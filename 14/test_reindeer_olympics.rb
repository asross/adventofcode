require 'minitest/autorun'
require_relative './reindeer_olympics'

class TestReindeerOlympics < Minitest::Test
  def test_reindeer
    reindeer = Reindeer.new('Comet', 14, 10, 127)

    assert_equal 0, reindeer.distance_at(0)
    assert_equal 140, reindeer.distance_at(10)
    assert_equal 70, reindeer.distance_at(5)
    assert_equal 140, reindeer.distance_at(130)
    assert_equal 140, reindeer.distance_at(137)
    assert_equal 210, reindeer.distance_at(142)
    assert_equal 280, reindeer.distance_at(150)
  end

  def test_reindeer_olympics
    olympics = ReindeerOlympics.new <<-OHDEER
Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.
Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds.
    OHDEER

    assert_equal([[1120, 'Comet'], [1056, 'Dancer']], olympics.lineup_at(1000))

    assert_equal({ 'Comet' => 312, 'Dancer' => 689 }, olympics.points_at(1000))
  end
end
