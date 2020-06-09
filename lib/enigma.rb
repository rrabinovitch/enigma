require_relative 'cipher'
require_relative 'key'

class Enigma < Cipher
  def enigma_setup(key, date)
    key_hash = generate_key_hash(key)
    offset_hash = generate_offset_hash(date)
    generate_shift_hash(key_hash, offset_hash)
  end

  def encrypt(message, key = Key.generate, date = format_date)
    shift_hash = enigma_setup(key, date)
    shifted_alphabets = shifted_alphabets(shift_hash[:A],
      shift_hash[:B], shift_hash[:C], shift_hash[:D])
    message_chars = message.downcase.chars
    encrypted_message = shift(message_chars, shifted_alphabets).chomp
    {encryption: encrypted_message, key: key, date: date}
  end

  def decrypt(ciphertext, key, date = format_date)
    shift_hash = enigma_setup(key, date)
    unshifted_alphabets = shifted_alphabets(-(shift_hash[:A]),
      -(shift_hash[:B]), -(shift_hash[:C]), -(shift_hash[:D]))
    ciphertext_chars = ciphertext.downcase.chars
    decrypted_message = shift(ciphertext_chars, unshifted_alphabets).chomp
    {decryption: decrypted_message, key: key, date: date}
  end
end
