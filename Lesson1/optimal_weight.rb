puts "Ведите свое имя"
name = gets.chomp
puts "Ведите свой рост"
height = gets.chomp.to_i
optimal = ((height - 110) * 1.15)
if optimal < 0 || optimal == 0
  puts "Ваш вес уже оптимальный"
else
  puts "#{name}, ваш идеальный вес #{optimal}"
end

