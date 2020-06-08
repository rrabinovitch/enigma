require './test/setup'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/key'

class KeyTest < Minitest::Test
  def test_it_exits
    key = Key.new
    assert_instance_of Key, key
  end

  def test_it_can_generate_key
    assert_instance_of String, Key.generate
    assert_equal 5, Key.generate.length
    assert_equal true, Key.generate.to_i.between?(0, 99_999)

    Key.stubs(:rand).returns(2715)
    assert_equal "02715", Key.generate
  end
end
