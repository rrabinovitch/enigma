require_relative 'enigma'

enigma = Enigma.new

handle = File.open(ARGV[0], "r")
message = handle.read
handle.close

if ARGV[2] && ARGV[3]
  encrypted_message = enigma.encrypt(message, ARGV[2], ARGV[3])
elsif !ARGV[2].nil? && ARGV[4].nil?
  encrypted_message = enigma.encrypt(message, ARGV[2])
else
  encrypted_message = enigma.encrypt(message)
end

writer = File.open(ARGV[1], "w")
writer.write(encrypted_message)
writer.close

puts "Created '#{ARGV[1]}' with the key #{encrypted_message[:key]} and date #{encrypted_message[:date]}"
