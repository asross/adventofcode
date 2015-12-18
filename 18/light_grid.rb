class Range
  def edges
    [first, last]
  end
end

class LightGrid
  def initialize(input)
    @grid = input.lines.map(&:strip)
  end

  def width; @grid[0].length; end
  def length; @grid.length; end
  def wide_end; 0..width-1; end
  def long_end; 0..length-1; end

  def on_grid?(i, j)
    long_end.include?(i) && wide_end.include?(j)
  end

  def on_edge?(i, j)
    long_end.edges.include?(i) && wide_end.edges.include?(j)
  end

  def evolve!
    next_grid = @grid.map(&:dup)
    length.times do |i|
      width.times do |j|
        next_grid[i][j] = next_state(i, j)
      end
    end
    @grid = next_grid
  end

  def repeatedly_evolve(n)
    yield 0 if block_given?
    n.times do |i|
      evolve!
      yield i+1 if block_given?
    end
  end

  def animate_evolutions(n)
    repeatedly_evolve(n) do |i|
      puts `clear`
      puts i == 0 ? "Initial state:" : "After #{i} step#{'s' unless i == 1}:"
      puts self
      puts "Lights on: #{n_lights}"
    end
  end

  def adjacencies
    [0, 1, -1].permutation(2).to_a + [[1, 1], [-1, -1]]
  end

  def n_neighbors(i, j)
    adjacencies.count do |x, y|
      on_grid?(x+i, y+j) && @grid[x+i][y+j] == '#'
    end
  end

  def n_lights
    @grid.join.count('#')
  end

  def to_s
    @grid.join("\n")
  end

  def next_state(i, j)
    n = n_neighbors(i, j)
    return '#' if @grid[i][j] == '#' && (2..3).include?(n)
    return '#' if @grid[i][j] == '.' && n == 3
    '.'
  end
end

class FixedCornerLightGrid < LightGrid
  def next_state(i, j)
    return '#' if on_edge?(i, j)
    super
  end
end
