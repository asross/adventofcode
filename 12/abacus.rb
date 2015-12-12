require 'json'

module Enumerable
  def sum_by(&block)
    total = 0
    each do |item|
      total += yield item
    end
    total.to_f
  end
end

def sum_across(json, ignore_red=false)
  case json
  when Numeric then json
  when Array then json.sum_by { |el| sum_across(el, ignore_red) }
  when Hash then
    json.sum_by do |k, v|
      return 0 if ignore_red && v == 'red'
      sum_across(v, ignore_red)
    end
  else 0
  end
end
