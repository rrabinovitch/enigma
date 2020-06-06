require 'minitest/autorun'
require 'minitest/pride'
require './lib/enigma'

class EnigmaTest < Minitest::Test
  def test_it_exits
    enigma = Enigma.new
    assert_instance_of Enigma, enigma
  end

  def test_it_can_encrypt_message_w_key_and_date
    enigma = Enigma.new
    encryption = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
      }
    assert_equal encryption, enigma.encrypt("hello world", "02715", "040895")
  end
end
