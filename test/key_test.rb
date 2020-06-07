require 'minitest/autorun'
require 'minitest/pride'
require './lib/key'

class EnigmaTest < Minitest::Test
  def test_it_exits
    key = Key.new
    assert_instance_of Key, key
  end

  def test_it_can_generate_number
    number = Key.number
    assert_instance_of String, number
    assert_equal 5, number.length
    assert_equal true, number.to_i.between?(0, 99999)
    # consider stubbing #rand method for additional testing
  end
end
