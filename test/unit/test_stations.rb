require 'helper'

class TestStations < MiniTest::Test
  def setup
    mocked('setup') do
      @stations = Station.all
    end
  end

  def test_size
    assert_equal(605, @stations.size)
  end

  def test_diff
    different = @stations.select{|s| s.shortname != s.longname}
    assert_equal(58, different.size)
  end

  def test_some
    assert_equal('PASSAU DONAU', @stations[23].shortname)
    assert_equal('PASSAU DONAU', @stations[23].longname)
  end
end
