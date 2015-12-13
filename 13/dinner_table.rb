require 'set'

class DinnerTable
  attr_reader :nodes, :edges

  def initialize(input)
    @nodes = Set.new
    @edges = Hash.new { |h, p1| h[p1] = Hash.new { |hh, p2| hh[p2] = 0 } }
    input.lines.each do |line|
      /(?<person1>[A-Z][a-z]+) would (?<change>lose|gain) (?<amount>\d+) happiness units by sitting next to (?<person2>[A-Z][a-z]+)/ =~ line
      @nodes << person1
      @nodes << person2
      @edges[person1][person2] = (change == 'lose' ? -1 : 1) * amount.to_i
    end
    @nodes = @nodes.to_a.sort
  end

  def size
    @nodes.count
  end

  def happinesses
    @nodes.permutation.lazy.map do |permutation|
      size.times.reduce(0) do |happiness, i|
        happiness += @edges[permutation[i]][permutation[(i-1) % size]]
        happiness += @edges[permutation[i]][permutation[(i+1) % size]]
      end
    end
  end

  def maximum_happiness
    happinesses.max
  end
end
