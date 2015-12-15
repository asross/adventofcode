require_relative './cookie_picker'

picker = CookiePicker.new(File.read('./input'))
puts picker.tastiest_cookie.tastiness
puts picker.tastiest_cookie_with_500_calories.tastiness
