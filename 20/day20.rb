def presents1(house)
  total = 0
  1.upto(house).each { |n| total += n * 10 if house % n == 0 }
  total
end
raise unless presents1(1) == 10
raise unless presents1(4) == 70

def presents2(house)
  total = 0
  min = [house / 50, 1].max
  min.upto(house) { |n| total += n * 11 if house % n == 0 }
  total
end
raise unless presents2(1) == 11

min_presents = 36000000
n = (1..Float::INFINITY).detect do |house|
  next unless house % 360 == 0 # semi-cheat
  p = presents1(house)
  puts "at #{house}, #{p}" if house % 10000 == 0
  p >= min_presents
end
puts "Part 1: #{n}"
n2 = (n..Float::INFINITY).detect do |house|
  next unless house % 360 == 0
  p = presents2(house)
  puts "at #{house}, #{p}" if house % 10000 == 0
  p >= min_presents
end
puts "Part 2: #{n2}"
