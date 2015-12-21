require 'ostruct'

class ItemShop
  attr_reader :weapons, :armors, :rings

  def initialize(input)
    @weapons, @armors, @rings = input.split("\n\n").map do |section|
      section.lines[1..-1].map do |line|
        name, cost, damage, armor = line.strip.split(/\s{2,}/)
        OpenStruct.new(name: name, cost: cost.to_i, damage: damage.to_i, armor: armor.to_i)
      end
    end
  end

  def null_item
    OpenStruct.new(damage: 0, armor: 0, cost: 0)
  end

  def each_weapon
    return to_enum(__method__) unless block_given?
    weapons.each { |weapon| yield weapon }
  end

  def each_armor
    return to_enum(__method__) unless block_given?
    yield null_item
    armors.each { |armor| yield armor }
  end

  def each_ring_combination
    return to_enum(__method__) unless block_given?
    yield null_item, null_item
    rings.each { |ring| yield ring, null_item }
    rings.combination(2).each { |ring1, ring2| yield ring1, ring2 }
  end

  def each_combination
    return to_enum(__method__) unless block_given?
    each_weapon do |weapon|
      each_armor do |armor|
        each_ring_combination do |ring1, ring2|
          yield weapon, armor, ring1, ring2
        end
      end
    end
  end
end
