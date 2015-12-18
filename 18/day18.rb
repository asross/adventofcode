require_relative './light_grid'

input = File.read('./input')
LightGrid.new(input).animate_evolutions(100)
sleep 1
FixedCornerLightGrid.new(input).animate_evolutions(100)
