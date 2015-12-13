require_relative './dinner_table'

table = DinnerTable.new(File.read('./input'))

puts table.maximum_happiness

table.nodes << 'Yourself'

puts table.maximum_happiness
