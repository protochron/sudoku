def factoral(x)
  return x if (x == 1)
  x * factoral(x - 1)
end

start = ARGV[0].to_i
if start.is_a?(Integer) && start > 0
  result = factoral(start)
  puts "Factoral of #{start} is #{result}"
else
  puts "You need to supply a number greater than or equal to 1"
  exit 1
end
