hash = {}
num = 1
('a'..'z').each do |letter|
  hash[letter] = num
  num += 1
end
hash.select! { |k, v| %w[a e i o u y].include?(k) }
puts hash