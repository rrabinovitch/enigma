require 'date'

class Cipher
  attr_reader :today, :alphabet

  def initialize
    @today = Date.today
    @alphabet = ("a".."z").to_a << " "
  end

  def format_date
    @today.strftime("%d%m%y")
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

  def character_translator(char, alphabets, i)
    translate = {1 => :A, 2 => :B, 3 => :C, 0 => :D}
    remainder = i % 4
    alphabets[translate[remainder]][char]
  end

  def shift(text_chars, alphabets)
    text_chars.map.with_index(1) do |char, i|
      if @alphabet.include?(char)
        character_translator(char, alphabets, i)
      else
        char
      end
    end.join
  end
end
