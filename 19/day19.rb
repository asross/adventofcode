require_relative './replacement_machine'

machine = ReplacementMachine.new(File.read('./replacements'))

molecule = File.read('./medicine_molecule').strip

puts machine.replacements_for(molecule).count

path = machine.shortest_path_to(molecule)

puts "\n"
puts path
puts "\n"

puts path.length - 1
