require_relative 'cc'

if CC.process(*ARGV)
  puts 'Valid'
else
  puts 'Invalid'
end
