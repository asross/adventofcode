class Reindeer
  attr_reader :name

  def initialize(name, flight_speed, flight_duration, rest_duration)
    @name = name
    @flight_speed = flight_speed
    @flight_duration = flight_duration
    @rest_duration = rest_duration
  end

  def period
    @flight_duration + @rest_duration
  end

  def distance_per_period
    @flight_speed * @flight_duration
  end

  def distance_at(time)
    fully_completed_periods = (time / period)
    time_through_last_period = (time % period)
    progress_through_last_period = [time_through_last_period / @flight_duration.to_f, 1].min
    (fully_completed_periods + progress_through_last_period) * distance_per_period
  end
end

class ReindeerOlympics
  def initialize(input)
    @reindeer = input.lines.map do |line|
      /(?<name>[A-Z][a-z]+) can fly (?<flight_speed>\d+) km\/s for (?<flight_duration>\d+) seconds, but then must rest for (?<rest_duration>\d+) seconds./ =~ line
      Reindeer.new(name, flight_speed.to_i, flight_duration.to_i, rest_duration.to_i)
    end
  end

  def lineup_at(time)
    @reindeer.map { |r| [r.distance_at(time), r.name] }
  end

  def points_at(time)
    points = Hash.new { |h, deer| h[deer] = 0 }
    1.upto(time).each do |second|
      lineup = lineup_at(second)
      max_distance, _deer = lineup.max
      lineup.select { |distance, _| distance == max_distance }.each do |_, leadeer|
        points[leadeer] += 1
      end
    end
    points
  end
end
