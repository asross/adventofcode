require 'minitest/autorun'
require_relative './character'

class TestCharacter < Minitest::Test
  def test_battle
    player = Character.new(8, 5, 5)
    boss = Character.new(12, 7, 2)
    remaining_hp = player.battle(boss)
    assert_equal 2, remaining_hp[player]
    assert_equal 0, remaining_hp[boss]
    assert_equal true, player.beats?(boss)
  end
end
