require 'minitest/autorun'
require 'minitest/pride'
require './lib/key'

class EnigmaTest < Minitest::Test
  def setup
    @key = Key.new
    @number = Key.number
  end
  def test_it_exits
    assert_instance_of Key, @key
  end

  def test_it_can_generate_number
    assert_instance_of String, @number
    assert_equal 5, @number.length
    assert_equal true, @number.to_i.between?(0, 99999)
    # consider stubbing #rand method for additional testing
  end

  def test_it_can_create_key_hash
    assert_instance_of Hash, Key.key_hash
  end
end
