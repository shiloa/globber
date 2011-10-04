require "test/unit"
require "fnmatch"

class TestFnmatch < Test::Unit::TestCase

  def test_single_match
		assert_equal FNMatch.match('john', '*hn'), true
		assert_equal FNMatch.match('john', 'hn'),  false
  end

  def test_single_match_reversed
		assert_equal FNMatch.match_r('*hn', 'john'), true
		assert_equal FNMatch.match_r('hn', 'john'),  false
  end

  def test_match_single_string_with_multiple_patterns
    assert_equal FNMatch.match_any_pattern('john', ['*hn', 'boe', 'pi*p']), true
    assert_equal FNMatch.match_any_pattern('john', ['hn', 'boe',  'pi*p']), false
  end

  def test_match_single_pattern_with_multiple_strings
    assert_equal FNMatch.match_any_string('*hn', ['john', 'sam', 'jeeves']), true
    assert_equal FNMatch.match_any_string('*hn', ['amy', 'sue',  'sally']),  false
  end
end
