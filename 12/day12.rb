require_relative './abacus'

j = JSON.parse(File.read('./document.json'))
puts sum_across(j)
puts sum_across(j, true)
