require_relative 'enigma'

enigma = Enigma.new

handle = File.open(ARGV[0], "r")
message = handle.read
handle.close

if !ARGV[3].nil? && !ARGV[4].nil?
  encrypted_message = enigma.encrypt(incoming_text, ARGV[3], ARGV[4])
elsif !ARGV[3].nil? && ARGV[4].nil?
  encrypted_message = enigma.encrypt(incoming_text, ARGV[3])
else
  encrypted_message = enigma.encrypt(incoming_text)
end
