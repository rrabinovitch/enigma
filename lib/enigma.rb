require 'date'

class Enigma
  attr_reader :date

  def initialize
    @date = Date.today.strftime("%d%m") + Date.today.strftime("%Y")[2..3]
    # eventually separate date into its own class to be able to better test date attribute and formatting
    # consider whether it's an issue for the date attribute to be defined by the date on which the enigma instance was initialized - do we need more flexibility?
  end

  def encrypt(message, key, date = @date)
    # identify A, B, C, and D keys based on key argument value
    # identify A, B, C, and D offsets based on date argument value
    # add keys and offsets to identify A, B, C, and D shifts
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
