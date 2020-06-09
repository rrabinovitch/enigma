require_relative 'enigma'

enigma = Enigma.new

handle = File.open(ARGV[0], "r")
ciphertext = handle.read
handle.close

if ARGV[2] && ARGV[3]
  decrypted_message = enigma.decrypt(ciphertext, ARGV[2], ARGV[3])
elsif !ARGV[2].nil? && ARGV[4].nil?
  decrypted_message = enigma.decrypt(ciphertext, ARGV[2])
else
  decrypted_message = enigma.decrypt(ciphertext)
end

writer = File.open(ARGV[1], "w")
writer.write(decrypted_message)
writer.close

key = decrypted_message[:key]
date = decrypted_message[:date]

puts "Created '#{ARGV[1]}' with the key #{key} and date #{date}"
