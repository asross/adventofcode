require 'minitest/autorun'
require_relative './wizard_simulator'

class WizardSimulatorTest < Minitest::Test
  def test_wizard_simulator
    simulator = WizardSimulator.new(10, 250, 13, 8, [:magic_missile, :poison])
    assert simulator.player_wins?
    assert_equal 2, simulator.hp
    assert_equal 24, simulator.mana

    simulator = WizardSimulator.new(10, 250, 14, 8, [:magic_missile, :poison, :drain, :shield, :recharge])
    assert simulator.player_wins?
    assert_equal 1, simulator.hp
    assert_equal 114, simulator.mana
  end
end
