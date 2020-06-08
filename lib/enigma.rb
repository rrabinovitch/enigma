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

  def encrypt(message, key = Key.generate, date = formatted_date)
    # identify A, B, C, and D keys based on key argument value
    key_hash = generate_key_hash(key)
    # identify A, B, C, and D offsets based on date argument value
    offset_hash = generate_offset_hash(date)
    # add keys and offsets to identify A, B, C, and D shifts
    shift_hash = generate_shift_hash(key_hash, offset_hash)
    # acreate an array of chars that comprise message argument value

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
    encryption_result = {
      encryption: "",
      key: key,
      date: date
      }
  end
end
