require 'minitest/autorun'
require 'minitest/pride'
require './lib/enigma'

class EnigmaTest < Minitest::Test
  def test_it_exits
    enigma = Enigma.new
    assert_instance_of Enigma, enigma
  end

  def test_it_has_date
    enigma = Enigma.new
    assert_instance_of String, enigma.date
    assert_equal 6, enigma.date.length
    # consider how to use stub here: Date.stubs(:today).returns()
  end

  def test_it_can_generate_key_hash
    enigma = Enigma.new
    key = "06289"
    assert_instance_of Hash, enigma.generate_key_hash(key)

    [:A, :B, :C, :D].each do |hash_key|
      assert_equal true, enigma.generate_key_hash(key).keys.include?(hash_key)
    end

    enigma.generate_key_hash(key).values.each do |enigma_key|
      assert_equal 2, enigma_key.length
      assert_equal true, enigma_key.to_i.between?(0, 99)
    end
  end

  def test_it_has_an_alphabet_with_a_space
    skip
    enigma = Enigma.new
    assert_equal true, enigma.alphabet.include?(" ")
    assert_equal 27, enigma.alphabet.count
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
