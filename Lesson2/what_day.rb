puts 'День:'
day = gets.chomp.to_i

puts 'Месяц:'
month = gets.chomp.to_i

puts 'Год:'
year = gets.chomp.to_i

days_in_mon = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

if (year % 4 == 0) && !(year % 100 == 0) || (year % 400 == 0)
  days_in_mon[1] = 29
end
day_number_year = day + days_in_mon.take(month - 1).sum

puts day_number_year