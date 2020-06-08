require_relative 'cipher'
require_relative 'key'

class Enigma < Cipher
  def encrypt(message, key = Key.generate, date = format_date)
    key_hash = generate_key_hash(key)
    offset_hash = generate_offset_hash(date)
    shift_hash = generate_shift_hash(key_hash, offset_hash)
    shifted_alphabets = shifted_alphabets(shift_hash[:A],
      shift_hash[:B], shift_hash[:C], shift_hash[:D])
    message_chars = message.downcase.chars
    encrypted_message = message_chars.map.with_index(1) do |char, i|
      if @alphabet.include?(char)
        if i % 4 == 1
          shifted_alphabets[:A][char]
        elsif i % 4 == 2
          shifted_alphabets[:B][char]
        elsif i % 4 == 3
          shifted_alphabets[:C][char]
        elsif i % 4 == 0
          shifted_alphabets[:D][char]
        end
      else
        char
      end
    end.join
    {encryption: encrypted_message, key: key, date: date}
  end

  def decrypt(ciphertext, key, date = format_date)
    key_hash = generate_key_hash(key)
    offset_hash = generate_offset_hash(date)
    shift_hash = generate_shift_hash(key_hash, offset_hash)
    unshifted_alphabets = shifted_alphabets(-(shift_hash[:A]),
      -(shift_hash[:B]), -(shift_hash[:C]), -(shift_hash[:D]))
    ciphertext_chars = ciphertext.downcase.chars
    decrypted_message = ciphertext_chars.map.with_index(1) do |char, i|
      if @alphabet.include?(char)
        if i % 4 == 1
          unshifted_alphabets[:A][char]
        elsif i % 4 == 2
          unshifted_alphabets[:B][char]
        elsif i % 4 == 3
          unshifted_alphabets[:C][char]
        elsif i % 4 == 0
          unshifted_alphabets[:D][char]
        end
      else
        char
      end
    end.join
    {decryption: decrypted_message, key: key, date: date}
  end
end
