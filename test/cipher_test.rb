require './test/setup'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/cipher'

class CipherTest < Minitest::Test
  def test_it_exists
    cipher = Cipher.new
    assert_instance_of Cipher, cipher
  end
end
