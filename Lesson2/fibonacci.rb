arr = [0, 1]
loop do
  fibonnacci = arr[-1] + arr[-2]
  break if fibonnacci > 100

  arr.push(fibonnacci)
end

puts arr