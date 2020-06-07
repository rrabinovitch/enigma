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

  def test_it_can_generate_abcd_keys
    assert_instance_of Hash, Key.abcd_keys
    [:A, :B, :C, :D].each do |hash_key|
      assert_equal true, Key.abcd_keys.include?(hash_key)
    end
    Key.abcd_keys.values.each do |enigma_key|
      assert_equal 2, enigma_key.length
      assert_equal true, enigma_key.to_i.between?(0, 99)
    end
  end
end
