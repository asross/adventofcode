require 'pry'
require 'set'

class TravelingSanta
  def initialize(distances)
    @distances = Hash.new { |h, location| h[location] = {} }
    @locations = Set.new
    distances.lines.each do |line|
      locations, distance = line.split(' = ')
      loc1, loc2 = locations.split(' to ')
      @locations << loc1
      @locations << loc2
      @distances[loc1][loc2] = distance.to_i
      @distances[loc2][loc1] = distance.to_i
    end
  end

  def best_route_distance_by(&best)
    possible_distances = @locations.map { |location| distance_from(location, @locations-[location], best) }
    best.call(possible_distances)
  end

  def distance_from(current_location, remaining_locations, best, distance_so_far=0)
    if remaining_locations.length == 0
      distance_so_far
    else
      possible_distances = []
      @distances[current_location].each do |location, distance|
        next unless remaining_locations.include?(location)
        possible_distances << distance_from(location, remaining_locations-[location], best, distance+distance_so_far)
      end
      best.call(possible_distances)
    end
  end
end

traveling_santa = TravelingSanta.new(File.read('./distances'))

puts traveling_santa.best_route_distance_by(&:min)
puts traveling_santa.best_route_distance_by(&:max)
