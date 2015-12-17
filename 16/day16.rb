require_relative './aunt_sue'

aunts = File.read('./input').lines.map { |line| AuntSue.new(line) }
exact_criteria = ExactAuntCriteria.new(File.read('./criteria'))
fuzzy_criteria = FuzzyAuntCriteria.new(File.read('./criteria'))

puts aunts.detect { |aunt| aunt.matches?(exact_criteria) }
puts aunts.detect { |aunt| aunt.matches?(fuzzy_criteria) }
