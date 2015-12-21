require 'minitest/autorun'
require_relative './item_shop'

class TestItemShop < Minitest::Test
  def test_item_shop
    shop = ItemShop.new <<-ITEMS
Weapons:
Rusty Chicken   10   5   7

Armor:
Platemail  12  2  0
Bowlmail  0  1  1

Rings:
Damage +1   25  1  0
Damage +7   30  7  0
    ITEMS

    assert_equal shop.weapons.map(&:name), ['Rusty Chicken']
    assert_equal shop.armors.map(&:name), %w(Platemail Bowlmail)
    assert_equal shop.rings.map(&:name), ['Damage +1', 'Damage +7']

    assert_equal shop.each_weapon.count, 1
    assert_equal shop.each_armor.count, 3
    assert_equal shop.each_ring_combination.count, 4
    assert_equal shop.each_combination.count, 12
  end
end
