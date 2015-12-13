require 'minitest/autorun'
require_relative './dinner_table.rb'

class TestDinnerTable < Minitest::Test
  def test_dinner_table
    table = DinnerTable.new <<-JOY
Alice would gain 54 happiness units by sitting next to Bob.
Alice would lose 79 happiness units by sitting next to Carol.
Alice would lose 2 happiness units by sitting next to David.
Bob would gain 83 happiness units by sitting next to Alice.
Bob would lose 7 happiness units by sitting next to Carol.
Bob would lose 63 happiness units by sitting next to David.
Carol would lose 62 happiness units by sitting next to Alice.
Carol would gain 60 happiness units by sitting next to Bob.
Carol would gain 55 happiness units by sitting next to David.
David would gain 46 happiness units by sitting next to Alice.
David would lose 7 happiness units by sitting next to Bob.
David would gain 41 happiness units by sitting next to Carol.
    JOY
    assert_equal table.nodes, %w(Alice Bob Carol David)
    assert_equal table.edges['Alice']['Bob'], 54
    assert_equal table.edges['Carol']['Alice'], -62

    assert_equal table.maximum_happiness, 330
  end
end
