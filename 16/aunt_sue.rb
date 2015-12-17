def parse_pair(pair)
  attribute, value = pair.split(':').map(&:strip)
  [attribute, value.to_i]
end

class AuntCriteria
  attr_reader :attributes

  def initialize(input)
    @attributes = Hash[input.lines.map(&method(:parse_pair))]
  end
end

class ExactAuntCriteria < AuntCriteria
  def accepts?(attribute, value)
    return true if attributes[attribute].nil?
    attributes[attribute] == value
  end
end

class FuzzyAuntCriteria < AuntCriteria
  def accepts?(attribute, value)
    return true if attributes[attribute].nil?
    case attribute
    when 'cats', 'trees'
      attributes[attribute] < value
    when 'pomeranians', 'goldfish'
      attributes[attribute] > value
    else
      attributes[attribute] == value
    end
  end
end

class AuntSue
  attr_reader :number, :attributes

  def initialize(line)
    _, number, attributes = line.split(/Sue (\d+):/)
    @number = number.to_i
    @attributes = Hash[attributes.split(',').map(&method(:parse_pair))]
  end

  def matches?(criteria)
    attributes.all? do |attribute, value|
      criteria.accepts?(attribute, value)
    end
  end

  def to_s
    "Sue #{number}"
  end
end
