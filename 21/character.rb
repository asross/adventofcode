class Character
  attr_reader :hp, :damage, :armor

  def initialize(hp, damage, armor)
    @hp = hp
    @damage = damage
    @armor = armor
  end

  def damage_from(attacker)
    [1, attacker.damage - armor].max
  end

  def battle(other)
    hps = { self => hp, other => other.hp }
    [hps.keys, hps.keys.reverse].cycle do |attacker, defender|
      hps[defender] -= defender.damage_from(attacker)
      return hps if hps[defender] <= 0
    end
  end

  def beats?(other)
    battle(other)[self] > 0
  end
end
