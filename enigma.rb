require_relative 'cipher'
require_relative 'key'

class Enigma < Cipher
  # is it necessary to define initialize and call super?

  def encrypt(message, key = Key.generate, date = format_date)
    key_hash = generate_key_hash(key)
    offset_hash = generate_offset_hash(date)
    shift_hash = generate_shift_hash(key_hash, offset_hash)
    shifted_alphabets = shifted_alphabets(shift_hash[:A],
      shift_hash[:B], shift_hash[:C], shift_hash[:D])
    message_chars = message.downcase.chars
    encrypted_message = shift(message_chars, shifted_alphabets)
    {encryption: encrypted_message, key: key, date: date}
  end

  def decrypt(ciphertext, key, date = format_date)
    key_hash = generate_key_hash(key)
    offset_hash = generate_offset_hash(date)
    shift_hash = generate_shift_hash(key_hash, offset_hash)
    unshifted_alphabets = shifted_alphabets(-(shift_hash[:A]),
      -(shift_hash[:B]), -(shift_hash[:C]), -(shift_hash[:D]))
    ciphertext_chars = ciphertext.downcase.chars
    decrypted_message = shift(ciphertext_chars, unshifted_alphabets)
    {decryption: decrypted_message, key: key, date: date}
  end
end
