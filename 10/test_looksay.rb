require 'minitest/autorun'

require_relative './looksay'

class TestLooksay < Minitest::Test
  def test_transforms
    assert_equal looksay("1"), "11"
    assert_equal looksay("11"), "21"
    assert_equal looksay("21"), "1211"
    assert_equal looksay("1211"), "111221"
  end
end
