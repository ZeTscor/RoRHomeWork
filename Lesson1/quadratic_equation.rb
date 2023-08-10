puts "Введите 1-ый коэффициент"
a = gets.chomp.to_i
puts "Введите 2-ый коэффициент"
b = gets.chomp.to_i
puts "Введите 3-ый коэффициент"
c = gets.chomp.to_i

d = b ** 2 - (4 * a * c)
if d.zero?
  x = (-1.0 * b) / (2 * a)
  puts "D = #{d}, x1 = x2 = #{x}"
elsif d.positive?
  x1 = (-1.0 * b + Math.sqrt(d)) / 2 * a
  x2 = (-1.0 * b - Math.sqrt(d)) / 2 * a
  puts "D = #{d}, x1 = #{x1}, x2 = #{x2}"
else
  puts "D = #{d}, Корней нет"
end


