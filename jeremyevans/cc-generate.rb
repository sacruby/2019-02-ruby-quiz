require_relative 'cc'

if number = CC.generate(ARGV.first.to_i)
  puts number.split(//).each_slice(4).map(&:join).join(' ')
else
  puts "Invalid"
end
