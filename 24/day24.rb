require_relative './sleigh_balancer'

packages = File.read('./input').lines.map { |l| l.strip.to_i }

sb3 = SleighBalancer.new(packages, 3)
puts sb3.best_split.inject(:*)

sb4 = SleighBalancer.new(packages, 4)
puts sb4.best_split.inject(:*)

