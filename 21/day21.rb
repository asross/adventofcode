module Enumerable
  def sum_by
    inject(0) { |total, item| total + yield(item) }
  end
end

require_relative './item_shop'
require_relative './character'

shop = ItemShop.new(File.read('./items'))
boss = Character.new(103, 9, 2)

min_cost = Float::INFINITY
max_cost = 0
shop.each_combination do |*items|
  cost = items.sum_by(&:cost)
  player = Character.new(100, items.sum_by(&:damage), items.sum_by(&:armor))
  if cost < min_cost && player.beats?(boss)
    min_cost = cost
  end
  if cost > max_cost && !player.beats?(boss)
    max_cost = cost
  end
end
puts min_cost
puts max_cost
