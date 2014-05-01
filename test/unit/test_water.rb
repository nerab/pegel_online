require 'helper'

class TestWater < MiniTest::Test
  def setup
    mocked('setup') do
      @waters = Water.all
    end
  end

  def test_size
    mocked{
      assert_equal(42, @waters.size)
    }
  end
end
