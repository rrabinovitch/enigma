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
    encryption_result = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
      }
    assert_equal encryption_result, enigma.encrypt("hello world", "02715", "040895")
  end
end


# ### LATER TESTS
# def test_it_can_decrypt_message_w_key_and_date
#   enigma = Enigma.new
#   decryption_result = {
#     decryption: "hello world",
#     key: "02715",
#     date: "040895"
#     }
#   assert_equal decryption_result, enigma.decrypt("keder ohulw", "02715", "040895")
# end
#
#
# def test_it_can_encrypt_message_w_key_and_no_date
#   # encrypt a message with a key (uses today's date)
#   pry(main)> encrypted = enigma.encrypt("hello world", "02715")
#   #=> # encryption hash here
# end
#
# def test_it_can_decrypt_message_w_key_and_no_date
#   #decrypt a message with a key (uses today's date)
#   pry(main) > enigma.decrypt(encrypted[:encryption], "02715")
#   #=> # decryption hash here
# end
#
# def test_it_can_encrypt_message_w_no_key_and_no_date
#   # encrypt a message (generates random key and uses today's date)
#   pry(main)> enigma.encrypt("hello world")
#   #=> # encryption hash here
# end
