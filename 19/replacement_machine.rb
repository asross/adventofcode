require 'set'

class ReplacementMachine
  def initialize(replacements)
    @replacements = replacements.lines.map do |line|
      line.split(' => ').map(&:strip)
    end.sort_by { |substring, replacement| -replacement.length }
  end

  def replacements_for(string)
    @replacements.each_with_object(Set.new) do |(substring, replacement), set|
      string.to_enum(:scan, substring).each do
        m = Regexp.last_match
        set << m.pre_match + replacement + m.post_match
      end
    end
  end

  def reverse_replacements_for(string)
    @replacements.each_with_object(Set.new) do |(substring, replacement), set|
      string.to_enum(:scan, replacement).each do
        m = Regexp.last_match
        set << m.pre_match + substring + m.post_match
      end
    end
  end

  def shortest_path_to(molecule)
    # use A* with shortness of final string as heuristic (not 100% sure if
    # that's admissable)
    frontier = [[molecule]]
    while node = frontier.pop
      return node if node.last == 'e'
      reverse_replacements_for(node.last).each do |string|
        frontier << (node + [string])
      end
      frontier.sort_by! {|node| -node.last.length }
    end
  end
end
