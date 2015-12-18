require 'minitest/autorun'
require_relative './light_grid'

class TestLightGrid < Minitest::Test
  def test_evolve
    light_grid = LightGrid.new <<-LIGHTS
.#.#.#
...##.
#....#
..#...
#.#..#
####..
    LIGHTS

    light_grid.repeatedly_evolve(4)

    assert_equal 4, light_grid.n_lights
  end
end

class TestFixedCornerLightGrid < Minitest::Test
  def test_evolve
    fc_light_grid = FixedCornerLightGrid.new <<-LIGHTS
##.#.#
...##.
#....#
..#...
#.#..#
####.#
    LIGHTS

    fc_light_grid.repeatedly_evolve(5)

    assert_equal 17, fc_light_grid.n_lights
  end
end
