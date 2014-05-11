require 'helper'

class TestWater < MiniTest::Test
  def setup
    @how = Water.new('HOW', 'HAVEL-ODER-WASSERSTRASSE')
  end

  def test_empty
    w = Water.new
    refute_nil(w)
  end

  def test_equal
    assert_equal(@how, Water.new('HOW', 'HAVEL-ODER-WASSERSTRASSE'))
  end

  def test_not_equal
    refute_equal(@how, Water.new('XHOW', 'HAVEL-ODER-WASSERSTRASSE'))
    refute_equal(@how, Water.new('HOW', 'XHAVEL-ODER-WASSERSTRASSE'))
  end

  def test_attributes
    refute_nil(@how)
    assert_equal('HOW', @how.shortname)
    assert_equal('HAVEL-ODER-WASSERSTRASSE', @how.longname)
  end
end
