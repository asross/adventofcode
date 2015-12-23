require_relative './little_computer'

computer = LittleComputer.new(File.read('./input'))
computer.execute!

puts computer.register_b

distracted_computer = LittleComputer.new(File.read('./input'))
distracted_computer.set('a', 1)
distracted_computer.execute!

puts distracted_computer.register_b
