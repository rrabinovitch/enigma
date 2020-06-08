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
end
