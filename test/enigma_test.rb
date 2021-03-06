require './test/setup'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/enigma'

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
    Date.stubs(:today).returns(Date.new(1995, 8, 4))
    enigma = Enigma.new
    assert_instance_of String, enigma.format_date
    assert_equal 6, enigma.format_date.length
    assert_equal "040895", enigma.format_date
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
    assert_equal (("a".."z").to_a << " ").rotate(3), shifted_alphabet.values
  end

  def test_it_can_create_all_shifted_alphabets
    assert_equal 4, @enigma.shifted_alphabets(2, 27, 73, 20).keys.count
    assert_instance_of Hash, @enigma.shifted_alphabets(2, 27, 73, 20)
    assert_equal 4, @enigma.shifted_alphabets(2, 27, 73, 20).keys.count
    @enigma.shifted_alphabets(2, 27, 73, 20).each do |shift_type, shifted_alphabet|
      (("a".."z").to_a << " ").each do |char|
        assert_equal true, shifted_alphabet.values.include?(char)
      end
    end
  end

  def test_it_can_translate_character
    shifted_alphabets = @enigma.shifted_alphabets(3, 27, 73, 20)
    assert_equal "k", @enigma.character_translator("h", shifted_alphabets, 1)
    assert_equal "e", @enigma.character_translator("e", shifted_alphabets, 2)
    assert_equal "d", @enigma.character_translator("l", shifted_alphabets, 3)
    assert_equal "e", @enigma.character_translator("l", shifted_alphabets, 4)
  end

  def test_it_can_shift_text_based_on_alphabet_set
    characters = "hello world".chars
    shifted_alphabets = @enigma.shifted_alphabets(3, 27, 73, 20)
    assert_equal "keder ohulw", @enigma.shift(characters, shifted_alphabets)
  end

  def test_it_can_generate_enigma_setup
    key = "02715"
    date = "040895"
    shift_hash = {A: 3, B: 27, C: 73, D: 20}
    assert_equal shift_hash, @enigma.enigma_setup(key, date)
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

  def test_it_can_decrypt_ciphertext_w_key_and_date
    decryption_result_1 = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
      }
    decryption_result_2 = {
      decryption: "hello world!",
      key: "02715",
      date: "040895"
      }
    assert_equal decryption_result_1, @enigma.decrypt("keder ohulw", "02715", "040895")
    assert_equal decryption_result_2, @enigma.decrypt("Keder Ohulw!", "02715", "040895")
  end

  def test_it_can_decrypt_ciphertext_w_key_and_no_date
    decryption_result = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
      }
      @enigma.stubs(:format_date).returns("040895")
      assert_equal decryption_result, @enigma.decrypt("keder ohulw", "02715")
  end
end
