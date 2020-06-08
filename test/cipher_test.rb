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
    assert_instance_of String, @cipher.format_date
    assert_equal 6, @cipher.format_date.length
    # consider how to use stub here: Date.stubs(:today).returns()
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
    assert_equal ("a".."z").to_a << " ", shifted_alphabet.values.rotate(-3)
    # better way to test?
  end

  def test_it_can_create_all_shifted_alphabets
    assert_equal 4, @cipher.shifted_alphabets(2, 27, 73, 20).keys.count
    # need more robust assertions
  end

  def test_it_can_shift_text_based_on_alphabet_set
    skip
    shifted_alphabets = @cipher.shifted_alphabets(2, 27, 73, 20)
    chars = "keder".chars
    @cipher.stubs(:generate_shift_hash).returns({A: 3, B: 27, C: 73, D: 20})
    # @cipher.stubs(:format_date).returns("040895")
    # Key.stubs(:generate).returns("02715")
    assert_equal "keder", @cipher.shift(chars, shifted_alphabets)
  end
end