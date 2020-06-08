require_relative 'enigma'

enigma = Enigma.new

handle = File.open(ARGV[0], "r")
message = handle.read
handle.close
