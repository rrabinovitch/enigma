require 'minitest/autorun'
require 'minitest/pride'
require './lib/enigma'
require 'mocha/minitest'

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

  def test_it_has_alphabet_incl_space
    assert_equal true, @enigma.alphabet.include?(" ")
    assert_equal 27, @enigma.alphabet.count
  end

  def test_it_can_format_todays_date
    assert_instance_of String, @enigma.format_date
    assert_equal 6, @enigma.format_date.length
    # consider how to use stub here: Date.stubs(:today).returns()
  end

  def test_it_can_generate_key_hash
    key = "02715"
    key_hash = {:A=>2, :B=>27, :C=>71, :D=>15}
    assert_equal key_hash, @enigma.generate_key_hash(key)
  end

  def test_it_can_generate_offset_hash
    date = "040895"
    offset_hash = {:A=>1, :B=>0, :C=>2, :D=>5}
    assert_equal offset_hash, @enigma.generate_offset_hash(date)
  end

  def test_it_can_generate_shift_hash
    key_hash = {:A=>2, :B=>27, :C=>71, :D=>15}
    offset_hash = {:A=>1, :B=>0, :C=>2, :D=>5}
    shift_hash = {A: 3, B: 27, C: 73, D: 20}
    assert_equal shift_hash, @enigma.generate_shift_hash(key_hash, offset_hash)
  end

  def test_it_can_create_shifted_alphabet
    shifted_alphabet = @enigma.shift_alphabet(3)
    assert_equal ("a".."z").to_a << " ", shifted_alphabet.keys
    assert_equal ("a".."z").to_a << " ", shifted_alphabet.values.rotate(-3)
    # better way to test?
  end

  def test_it_can_create_all_shifted_alphabets
    assert_equal 4, @enigma.shifted_alphabets(2, 27, 73, 20).keys.count
    # need more robust assertions
  end

  def test_it_can_encrypt_message_w_key_and_date
    encryption_result_1 = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
      }
    encryption_result_2 = {
      encryption: "keder ohulw!",
      key: "02715",
      date: "040895"
      }
    assert_equal encryption_result_1, @enigma.encrypt("hello world", "02715", "040895")
    assert_equal encryption_result_2, @enigma.encrypt("Hello World!", "02715", "040895")
  end

  def test_it_can_encrypt_message_w_key_and_no_date
    encryption_result = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
      }
    @enigma.stubs(:format_date).returns("040895")
    assert_equal encryption_result, @enigma.encrypt("hello world", "02715")
  end

  def test_it_can_encrypt_message_w_no_key_and_no_date
    encryption_result = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
      }
    @enigma.stubs(:format_date).returns("040895")
    Key.stubs(:generate).returns("02715")
    assert_equal encryption_result, @enigma.encrypt("hello world")
  end
end
