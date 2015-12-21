strings = File.read('./strings').split("\n").map(&:strip)

puts strings.join.length - strings.map(&method(:eval)).join.length

puts strings.map(&:inspect).join.length - strings.join.length
