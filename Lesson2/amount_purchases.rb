storage = {}
loop do
  puts 'Товар:'
  name = gets.chomp
  if name == "СТОП"
    break
  end
  puts 'Цена:'
  price = gets.chomp.to_f
  puts 'Количество товара'
  count = gets.chomp.to_f
  puts 'что остановиться введите "СТОП"'
  storage[name] = { price: price, count: count }
end
full_prices = 0

storage.each do |product, about|
  amount = about[:price] * about[:count]
  full_prices += amount
  puts "#{product}: количество и ценна за шт #{about} полная стоймость: #{amount}"
end
puts "Итог: #{full_prices}"