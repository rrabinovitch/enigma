require 'date'
require_relative 'key'

class Enigma
  attr_reader :today, :alphabet

  def initialize
    @today = Date.today
    # consider whether it's an issue for the date attribute to be defined by the date on which the enigma instance was initialized - do we need more flexibility?
    @alphabet = ("a".."z").to_a << " "
  end

  def format_date
    @today.strftime("%d%m") + @today.strftime("%Y")[2..3]
  end

  def generate_key_hash(key)
    {A: key.slice(0..1).to_i,
      B: key.slice(1..2).to_i,
      C: key.slice(2..3).to_i,
      D: key.slice(3..4).to_i}
  end

  def generate_offset_hash(date)
    sqrd_date = date.to_i ** 2
    offset = sqrd_date.to_s.slice(-4..-1)
    {A: offset[0].to_i,
      B: offset[1].to_i,
      C: offset[2].to_i,
      D: offset[3].to_i}
  end

  def generate_shift_hash(key_hash, offset_hash)
    {A: key_hash[:A] + offset_hash[:A],
      B: key_hash[:B] + offset_hash[:B],
      C: key_hash[:C] + offset_hash[:C],
      D: key_hash[:D] + offset_hash[:D]}
  end

  def shift_alphabet(shift)
    i = 0
    @alphabet.reduce({}) do |shifted_alphabet, char|
      shifted_alphabet[char] = @alphabet.rotate(shift)[i]
      i += 1
      shifted_alphabet
    end
  end

  def shifted_alphabets(a_shift, b_shift, c_shift, d_shift)
    {A: shift_alphabet(a_shift),
      B: shift_alphabet(b_shift),
      C: shift_alphabet(c_shift),
      D: shift_alphabet(d_shift)}
  end

  def encrypt(message, key = Key.generate, date = formatted_date)
    key_hash = generate_key_hash(key)
    offset_hash = generate_offset_hash(date)
    shift_hash = generate_shift_hash(key_hash, offset_hash)
    shifted_alphabets = shifted_alphabets(shift_hash[:A], shift_hash[:B], shift_hash[:C], shift_hash[:D])
    # alphabet_a = shift_alphabet(shift_hash[:A])
    # alphabet_b = shift_alphabet(shift_hash[:B])
    # alphabet_c = shift_alphabet(shift_hash[:C])
    # alphabet_d = shift_alphabet(shift_hash[:D])
    message_chars = message.downcase.chars
    encrypted_message = message_chars.map.with_index(1) do |char, i|
      if @alphabet.include?(char)
        if i % 4 == 1
          shifted_alphabets[:A][char] # alphabet_a[char]
        elsif i % 4 == 2
          shifted_alphabets[:B][char] # alphabet_b[char]
        elsif i % 4 == 3
          shifted_alphabets[:C][char] # alphabet_c[char]
        elsif i % 4 == 0
          shifted_alphabets[:D][char] # alphabet_d[char]
        end
      else
        char
      end
    end.join
    {encryption: encrypted_message, key: key, date: date}
  end
end
