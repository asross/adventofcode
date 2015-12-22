require_relative './wizard_simulator'

puts WizardSimulator.cheapest_winning_simulation(50, 500, 58, 9).mana_spent
puts HardWizardSimulator.cheapest_winning_simulation(50, 500, 58, 9).mana_spent
