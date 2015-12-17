require_relative './container_set'

containers = File.read('./input').lines.map { |l| l.strip.to_i }
container_set = ContainerSet.new(containers)

puts container_set.ways_to_fit(150)
puts container_set.ways_to_most_efficiently_fit(150)
