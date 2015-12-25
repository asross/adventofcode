def next_code(prev_code)
  (prev_code * 252533) % 33554393
end

def code_index(row, column)
  # triangle numbers, n(n+1)/2, plus/minus an index
  n = (row + column) - 1
  n * (n+1) * 0.5 - (row - 1)
end

raise unless code_index(1, 1) == 1
raise unless code_index(2, 1) == 2
raise unless code_index(1, 2) == 3
raise unless code_index(4, 2) == 12

FIRST_CODE = 20151125
def nth_code(index)
  code = FIRST_CODE
  (index-1).to_i.times do
    code = next_code(code)
  end
  code
end
raise unless nth_code(1) == FIRST_CODE
raise unless nth_code(2) == 31916031

puts nth_code(code_index(2981, 3075))
