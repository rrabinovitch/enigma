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
    key_hash = {A: key.slice(0..1).to_i,
      B: key.slice(1..2).to_i,
      C: key.slice(2..3).to_i,
      D: key.slice(3..4).to_i}
  end

  def generate_offset_hash(date)
    sqrd_date = date.to_i ** 2
    offset = sqrd_date.to_s.slice(-4..-1)
    offset_hash = {A: offset[0].to_i,
      B: offset[1].to_i,
      C: offset[2].to_i,
      D: offset[3].to_i}
  end

  def generate_shift_hash(key_hash, offset_hash)
    shift_hash = {A: key_hash[:A] + offset_hash[:A],
      B: key_hash[:B] + offset_hash[:B],
      C: key_hash[:C] + offset_hash[:C],
      D: key_hash[:D] + offset_hash[:D]}
  end

  def shift_alphabet(shift)
    i = 0
    shifted_alphabet = @alphabet.reduce({}) do |shifted_alphabet, char|
      shifted_alphabet[char] = @alphabet.rotate(shift)[i]
      i += 1
      shifted_alphabet
    end
    shifted_alphabet
  end

  def encrypt(message, key = Key.generate, date = formatted_date)
    # identify A, B, C, and D keys based on key argument value
    key_hash = generate_key_hash(key)
    # identify A, B, C, and D offsets based on date argument value
    offset_hash = generate_offset_hash(date)
    # add keys and offsets to identify A, B, C, and D shifts
    shift_hash = generate_shift_hash(key_hash, offset_hash)
    # create hash that has OG alphabet chars as keys and rotated alphabet chars as values
    alphabet_a = shift_alphabet(shift_hash[:A])
    alphabet_b = shift_alphabet(shift_hash[:B])
    alphabet_c = shift_alphabet(shift_hash[:C])
    alphabet_d = shift_alphabet(shift_hash[:D])
    # create an array of chars that comprise message argument value
    message_chars = message.downcase.chars
    # for each message_chars element: alphabet_a[message_chars[0]] => returns shifted char
    encrypted_message = message_chars.map.with_index(1) do |char, i|
      if @alphabet.include?(char)
        if i %4 == 1
          # replace char w a_shift replacement
          alphabet_a[char]
        elsif i %4 == 2
          # replace char w b_shift replacement
          alphabet_b[char]
        elsif i %4 == 3
          # replace char w c_shift replacement
          alphabet_c[char]
        elsif i %4 == 0
          # replace char w d_shift replacement
          alphabet_d[char]
        end
      else
        char
      end
    end.join
    # return encryption_result = {:encryption => encryption, :key => key, :date => date}
    encryption_result = {
      encryption: encrypted_message,
      key: key,
      date: date
      }
  end
end
