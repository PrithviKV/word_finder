
$DICTIONARY = {
  "Nouns" =>[ "abcd", "c", "def", "h", "ij", "cde"],

"Verbs" =>[ "bc", "fg", "g", "hij", "bcd"],

"Articles" =>[ "a", "ac", "e"]
}


class Main

  attr_reader :substrings

  def initialize
    @substrings = Array.new
  end

  def is_a_noun?(str)
    return $DICTIONARY["Nouns"].include?(str)
  end

  def is_a_verb?(str)
    return $DICTIONARY["Verbs"].include?(str)
  end

  def is_an_article?(str)
    return $DICTIONARY["Articles"].include?(str)
  end

  def get_result
    final_result = []
    @substrings.each do |a|
     final_result.append(a) if is_a_noun?(a)
     final_result.append(a) if is_a_verb?(a)
     final_result.append(a) if is_an_article?(a)
    end
    return final_result
  end

  def get_all_substrings(str)
    s_length = str.length
    substrings_arr = []
    range = 0..str.length
    range.each do |n|
      substrings_arr.append(str[0..n]) if n<s_length
    end
    return substrings_arr
  end

  def get_length(str)
    return str.length if str
    return
  end

  def run(user_input)

    return puts "Please run this program with a valid string input" if user_input.empty?

    user_input = user_input[0]
    str_length = get_length(user_input)-1

    range = 0..str_length
    range.each do |n|
      @substrings.append(get_all_substrings(user_input[n..str_length]))
    end

    @substrings = @substrings.flatten
    result = get_result
    puts result
    return result
  end
end

app = Main.new
app.run(ARGV)

#--------------------------TEST--------------------------
require "test/unit"
require "test/unit/assertions"

class MainTest < Test::Unit::TestCase

  def test_get_length
    assert_equal 0, Main.new.get_length("")
    assert_equal 4, Main.new.get_length("Dino")
  end

  def test_get_all_substrings
    assert_equal ["h","hi","hij"],Main.new.get_all_substrings("hij")
  end

  def test_is_a_noun?
    assert_equal true,Main.new.is_a_noun?("abcd")
    assert_equal false,Main.new.is_a_noun?("zzz")
  end

  def test_is_a_verb?
    assert_equal true,Main.new.is_a_verb?("hij")
    assert_equal false,Main.new.is_a_verb?("zz")
  end

  def test_is_an_article?
    assert_equal true,Main.new.is_an_article?("e")
    assert_equal false,Main.new.is_an_article?("z")
  end

  def test_run
    assert_equal ["a", "abcd", "bc", "bcd", "c"],Main.new.run(ARGV << "abcd")
  end
end
