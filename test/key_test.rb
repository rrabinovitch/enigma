require 'minitest/autorun'
require 'minitest/pride'
require './lib/key'

class EnigmaTest < Minitest::Test
  def test_it_exits
    key = Key.new
    assert_instance_of Key, key
  end
end
