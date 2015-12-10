require_relative './looksay'

t = Time.now
n = "3113322113"
50.times do |i|
  n = looksay(n)
  puts "at #{i}: #{n.length}, #{(Time.now - t).round}s"
end
