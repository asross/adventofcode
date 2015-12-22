class WizardSimulator
  class DeadWizard < StandardError; end
  class DeadBoss < StandardError; end

  SPELLS = [:magic_missile, :drain, :shield, :poison, :recharge] # in order of cost

  def self.cheapest_winning_simulation(hp, mana, boss_hp, boss_dmg)
    each_possible_simulation(hp, mana, boss_hp, boss_dmg) do |simulation|
      if simulation.player_wins?
        return simulation
      end
    end
  end

  def self.each_possible_simulation(hp, mana, boss_hp, boss_dmg, n=1, &block)
    SPELLS.repeated_permutation(n).each do |spells|
      yield new(hp, mana, boss_hp, boss_dmg, spells)
    end
    each_possible_simulation(hp, mana, boss_hp, boss_dmg, n+1, &block)
  end

  attr_reader :mana_spent, :mana, :hp

  def initialize(hp, mana, boss_hp, boss_dmg, spells)
    @hp = hp
    @mana = mana
    @boss_hp = boss_hp
    @boss_dmg = boss_dmg
    @spells = spells # a list of spells to be cast this simulation

    @mana_spent = 0
    @effects = {}
    @tmp_armor = 0
  end

  def spells
    {
      magic_missile: {
        cost: 53,
        cast: ->{ @boss_hp -= 4 }
      },
      drain: {
        cost: 73,
        cast: ->{ @boss_hp -= 2; @hp += 2 }
      },
      shield: {
        cost: 113,
        cast: ->{ add_effect :shield, 6, ->{ @tmp_armor = 7 } }
      },
      poison: {
        cost: 173,
        cast: ->{ add_effect :poison, 6, ->{ @boss_hp -= 3 } }
      },
      recharge: {
        cost: 229,
        cast: ->{ add_effect :recharge, 5, ->{ @mana += 101 } }
      }
    }
  end

  def cast(spell_name)
    raise DeadWizard unless spell_name # running out of spells = death
    spell = spells[spell_name]
    cost = spell[:cost]
    raise DeadWizard unless @mana >= cost # unable to cast spell = death
    spell[:cast].call
    @mana -= cost
    @mana_spent += cost
  end

  def add_effect(effect_name, time, resolution)
    raise DeadWizard if @effects[effect_name] # effect already in play = death
    @effects[effect_name] = { timer: time, resolve: resolution }
  end

  def check_hp
    raise DeadWizard if @hp <= 0 # hp <= 0 = death
    raise DeadBoss if @boss_hp <= 0 # boss hp <= 0 = victory
  end

  def resolve_effects
    check_hp
    @tmp_armor = 0
    @effects.each do |_, effect|
      effect[:resolve].call
      effect[:timer] -= 1
    end
    @effects.reject! { |_, effect| effect[:timer] <= 0 }
    check_hp
  end

  def player_wins?
    player_turn
  rescue DeadWizard
    false
  rescue DeadBoss
    true
  end

  def player_turn
    resolve_effects
    cast @spells.pop
    boss_turn
  end

  def boss_turn
    resolve_effects
    @hp -= boss_damage
    player_turn
  end

  def boss_damage
    [@boss_dmg - @tmp_armor, 1].max
  end
end

class HardWizardSimulator < WizardSimulator
  def player_turn
    @hp -= 1
    super
  end
end
