require 'minitest/autorun'
require 'minitest/pride'
require './lib/enigma'

class EnigmaTest < Minitest::Test
  def setup
    @enigma = Enigma.new
  end

  def test_it_exits
    assert_instance_of Enigma, @enigma
  end

  def test_it_has_todays_date
    assert_instance_of Date, @enigma.today
  end

  def test_it_can_format_todays_date
    assert_instance_of String, @enigma.format_date
    assert_equal 6, @enigma.format_date.length
    # consider how to use stub here: Date.stubs(:today).returns()
  end

  def test_it_can_generate_key_hash
    key = "06289" # refactor to use stub eventually?
    key_hash = {:A=>6, :B=>62, :C=>28, :D=>89}
    assert_equal key_hash, @enigma.generate_key_hash(key)
  end

  def test_it_has_an_alphabet_with_a_space
    skip
    assert_equal true, @enigma.alphabet.include?(" ")
    assert_equal 27, @enigma.alphabet.count
  end

  def test_it_can_generate_offset_hash
    date = "070620"
    offset_hash = {:A=>"4", :B=>"4", :C=>"0", :D=>"0"}
    assert_equal offset_hash, @enigma.generate_offset_hash(date)
  end

  def test_it_can_encrypt_message_w_key_and_date
    skip
    encryption_result = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
      }
    assert_equal encryption_result, @enigma.encrypt("hello world", "02715", "040895")
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
