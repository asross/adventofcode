require_relative './reindeer_olympics'

olympics = ReindeerOlympics.new(File.read('./input'))

puts olympics.lineup_at(2503).max

puts olympics.points_at(2503).max_by { |k, points| points }
