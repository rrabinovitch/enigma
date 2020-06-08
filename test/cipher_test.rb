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

end
