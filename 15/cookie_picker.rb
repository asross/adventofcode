class Cookie
  def initialize(ingredients, quantities)
    ingredients.zip(quantities).each do |ingredient, quantity|
      ingredient.each do |attribute, value|
        scores[attribute] += quantity * value
      end
    end
  end

  def scores
    @scores ||= Hash.new { |h, attribute| h[attribute] = 0 }
  end

  def tastiness
    %w(capacity durability flavor texture).inject(1) do |tastiness, attribute|
      tastiness *= [scores[attribute], 0].max
    end
  end

  def calories
    scores['calories']
  end
end

class CookiePicker
  attr_reader :ingredients, :total_quantity

  def initialize(ingredients, total_quantity=100)
    @ingredients = ingredients.lines.map do |line|
      line.split(':').last.split(',').each_with_object({}) do |cell, h|
        attribute, value = cell.strip.split
        h[attribute] = value.to_i
      end
    end
    @total_quantity = total_quantity
  end

  def split(number, ways, numbers=[], &block)
    return to_enum(:split, number, ways, numbers) unless block_given?
    if ways == numbers.count + 1
      yield numbers + [number]
    else
      1.upto(number-1).each { |i| split(number-i, ways, numbers+[i], &block) }
    end
  end

  def best_cookie_by(picker)
    best_quantities = split(total_quantity, ingredients.length).max_by do |quantities|
      picker.call(Cookie.new(ingredients, quantities))
    end
    Cookie.new(ingredients, best_quantities)
  end

  def tastiest_cookie
    best_cookie_by ->(cookie) { cookie.tastiness }
  end

  def tastiest_cookie_with_500_calories
    best_cookie_by ->(cookie) { cookie.calories == 500 ? cookie.tastiness : 0 }
  end
end
