require 'minitest/autorun'
require_relative './cookie_picker'

class TestCookiePicker < Minitest::Test
  def test_cookie_picker
    picker = CookiePicker.new <<-INGREDIENTS
Butterscotch: capacity -1, durability -2, flavor 6, texture 3, calories 8
Cinnamon: capacity 2, durability 3, flavor -2, texture -1, calories 3
    INGREDIENTS
    assert_equal [[1,4],[2,3],[3,2],[4,1]], picker.split(5, 2).entries
    assert_equal 62842880, picker.tastiest_cookie.tastiness
    assert_equal 57600000, picker.tastiest_cookie_with_500_calories.tastiness
  end
end
