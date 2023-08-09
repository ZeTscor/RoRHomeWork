# frozen_string_literal: true

class Area_triangle
  puts "Ведите основание треугольника"
  base = gets.chomp
  puts "Ведите высоту треугольника"
  height = gets.chomp
  puts "Площадь составляет #{(1.0/2.0)*base.to_f*height.to_f}"
end
