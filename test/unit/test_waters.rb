require 'helper'

class TestWaters < MiniTest::Test
  def setup
    mocked('setup') do
      @waters = Water.all
    end
  end

  def test_size
    assert_equal(96, @waters.size)
  end

  def test_some
    assert_equal('ILMENAU', @waters[23].shortname)
    assert_equal('ILMENAU', @waters[23].longname)
  end
end
