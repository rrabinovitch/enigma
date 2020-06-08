require 'date'

class Cipher
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
end
