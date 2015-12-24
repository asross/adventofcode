class SleighBalancer
  attr_reader :n_groups, :packages

  def initialize(packages, n_groups)
    @packages = packages
    @n_groups = n_groups
  end

  def target_weight
    @target_weight ||= packages.inject(:+) / n_groups.to_f
  end

  def still_splittable?(others, n=n_groups-1)
    if n == 0
      true
    else
      min = (n == 1 ? others.length : 1)
      each_combination(others, min, others.length) do |c|
        return true if still_splittable?(others-c, n-1)
      end
      false
    end
  end

  def each_combination(array, min_length, max_length, sort=false, &block)
    combos = array.combination(min_length)
    combos = combos.to_a.sort_by! { |c| c.inject(:*) } if sort
    combos.each do |c|
      yield c if c.inject(:+) == target_weight
    end
    if min_length <= max_length
      each_combination(array, min_length+1, max_length, sort, &block)
    end
  end

  def best_split
    each_combination(packages, 1, packages.length-1, true) do |combo|
      return combo if still_splittable?(packages-combo)
    end
  end
end
