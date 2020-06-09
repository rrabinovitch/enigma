require './test/setup'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/cipher'

class CipherTest < Minitest::Test
  def setup
    @cipher = Cipher.new
  end

  def test_it_exists
    assert_instance_of Cipher, @cipher
  end

  def test_it_has_todays_date
    assert_instance_of Date, @cipher.today
  end

  def test_it_has_alphabet_incl_space
    assert_equal true, @cipher.alphabet.include?(" ")
    assert_equal 27, @cipher.alphabet.count
  end

  def test_it_can_format_todays_date
    skip
    assert_instance_of String, @cipher.format_date
    assert_equal 6, @cipher.format_date.length
    @cipher.stubs(:today).returns(Date.new(1995, 8, 4))
    assert_equal "040895", @cipher.format_date
  end

  def test_it_can_generate_key_hash
    key = "02715"
    key_hash = {:A=>2, :B=>27, :C=>71, :D=>15}
    assert_equal key_hash, @cipher.generate_key_hash(key)
  end

  def test_it_can_generate_offset_hash
    date = "040895"
    offset_hash = {:A=>1, :B=>0, :C=>2, :D=>5}
    assert_equal offset_hash, @cipher.generate_offset_hash(date)
  end

  def test_it_can_generate_shift_hash
    key_hash = {:A=>2, :B=>27, :C=>71, :D=>15}
    offset_hash = {:A=>1, :B=>0, :C=>2, :D=>5}
    shift_hash = {A: 3, B: 27, C: 73, D: 20}
    assert_equal shift_hash, @cipher.generate_shift_hash(key_hash, offset_hash)
  end

  def test_it_can_create_shifted_alphabet
    shifted_alphabet = @cipher.shift_alphabet(3)
    assert_equal ("a".."z").to_a << " ", shifted_alphabet.keys
    assert_equal (("a".."z").to_a << " ").rotate(3), shifted_alphabet.values
  end

  def test_it_can_create_all_shifted_alphabets
    assert_equal 4, @cipher.shifted_alphabets(2, 27, 73, 20).keys.count
    # need more robust assertions
  end

  def test_character_translater
    # translates one character at a time
  end

  def test_it_can_shift_text_based_on_alphabet_set
    characters = "hello world".chars
    shifted_alphabets = @cipher.shifted_alphabets(3, 27, 73, 20)
    assert_equal "keder ohulw", @cipher.shift(characters, shifted_alphabets)
  end
end
