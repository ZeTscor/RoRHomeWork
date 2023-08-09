# frozen_string_literal: true

class Right_triangle
  puts "Ведите первою сторону треугольника"
  side_a = gets.chomp.to_i
  puts "Ведите вторую сторону треугольника"
  side_b = gets.chomp.to_i
  puts "Ведите третью сторону треугольника"
  side_c = gets.chomp.to_i
  side_a2 = side_a ** 2
  side_b2 = side_b ** 2
  side_c2 = side_c ** 2
  if side_a == side_b && side_b == side_c
    puts "Треугольник равнобедренный и равносторонний, но не прямоугольный."
  elsif (side_a == side_b && side_a != side_c) || (side_b == side_c && side_c != side_a) || (side_a == side_c && side_a != side_b)
    puts "Треугольник равнобедренный"
  elsif (side_a2 + side_b2 == side_c2) || (side_c2 + side_b2 == side_a2) || (side_a2 + side_a2 == side_b2)
    puts 'Треугольник прямоугольный'
  else
    puts 'Треугольник ни равносторонний, ни равнобедренный, ни прямоугольный'
  end
end
