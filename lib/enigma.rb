require 'date'
require_relative 'key'

class Enigma
  attr_reader :date

  def initialize
    @date = Date.today.strftime("%d%m") + Date.today.strftime("%Y")[2..3]
    # eventually separate date into its own class to be able to better test date attribute and formatting
    # consider whether it's an issue for the date attribute to be defined by the date on which the enigma instance was initialized - do we need more flexibility?
  end

  def generate_key_hash(key)
    key_hash = {A: key.slice(0..1),
      B: key.slice(1..2),
      C: key.slice(2..3),
      D: key.slice(3..4)}
end

  def encrypt(message, key = Key.abcd_keys, date = @date)
    # identify A, B, C, and D keys based on key argument value
    key_hash = generate_key_hash(key)
    # identify A, B, C, and D offsets based on date argument value
    sqrd_date = date.to_i ** 2
    offset = sqrd_date.to_s.slice(-4..-1)
    a_offset = offset.chars[0]
    b_offset = offset.chars[1]
    c_offset = offset.chars[2]
    d_offset = offset.chars[3]
    # add keys and offsets to identify A, B, C, and D shifts
    a_shift = a_key.to_i + a_offset.to_i
    b_shift = b_key.to_i + b_offset.to_i
    c_shift = c_key.to_i + c_offset.to_i
    d_shift = d_key.to_i + d_offset.to_i
    # create an array of chars that comprise message argument value

    # iterate through array to apply each shift to its applicable characters
      # consider #map since the original array is being *transformed*
      # interation contains a conditional that identifies which shift should be used on each character
        # if char index == 1, 5, 9, etc ==> use A shift
        # if char index == 2, 6, 10, etc ==> use B shift
        # if char index == 3, 7, 11, etc ==> use C shift
        # if char index == 4, 8, 12, etc OR char index % 4 == 0 ==> use D shift
      # assign return value to variable called "encryption"
    # encryption_result = {:encryption => encryption, :key => key, :date => date}

    # refactoring to work with no key and date args:
      # assign key default value: key = Key.new
      # assign date default value: date = Date.today(strftime...)
  end
end
