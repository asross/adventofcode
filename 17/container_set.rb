class ContainerSet
  def initialize(containers)
    @containers = containers
  end

  def each_combination
    return to_enum(:each_combination) unless block_given?

    1.upto(@containers.count).each do |n|
      @containers.combination(n).each do |containers|
        yield containers
      end
    end
  end

  def ways_to_fit(quantity)
    each_combination.count { |containers| containers.inject(:+) == quantity }
  end

  def ways_to_most_efficiently_fit(quantity)
    best_number = Float::INFINITY
    count = 0
    each_combination do |containers|
      if containers.inject(:+) == quantity
        if containers.count == best_number
          count += 1
        elsif containers.count < best_number
          best_number = containers.count
          count = 1
        end
      end
    end
    count
  end
end
