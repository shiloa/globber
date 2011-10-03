require "test/unit"
require "fnmatch/fnmatch"

class TestFnmatch < Test::Unit::TestCase

  def test_single_match
		assert_equal FNMatch.fnmatch('john', '*hn'), true
		assert_equal FNMatch.fnmatch('john', 'hn'),  false
  end

  def test_single_match_reversed
		assert_equal FNMatch.fnmatch_r('*hn', 'john'), true
		assert_equal FNMatch.fnmatch_r('hn', 'john'),  false
  end

  def test_match_single_string_with_multiple_patterns
    assert_equal FNMatch.fnmatch_any_pat('john', ['*hn', 'boe', 'pi*p']), true
    assert_equal FNMatch.fnmatch_any_pat('john', ['hn', 'boe',  'pi*p']), false
  end

  def test_match_single_pattern_with_multiple_strings
    assert_equal FNMatch.fnmatch_any_str('*hn', ['john', 'sam', 'jeeves']), true
    assert_equal FNMatch.fnmatch_any_str('*hn', ['amy', 'sue',  'sally']),  false
  end
end
