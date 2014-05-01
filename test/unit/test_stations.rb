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

  def test_numbers
    groups = @stations.group_by{|s| s.number.size}
    assert_equal(6, groups.keys.size)

    distribution = {
      3 => 1,
      4 => 5,
      6 => 191,
      7 => 191,
      8 => 216,
      13 => 1
    }

    distribution.each do |length, count|
      assert_equal(count, groups[length].size, "Expect #{count} stations with a number #{length} characters long")
    end

    # Konstanz is the only station with a 3-character number
    konstanz = groups[3].first
    assert_equal('KONSTANZ', konstanz.shortname)
    assert_equal('906', konstanz.number)

    # Hattingen is the only station with a 13-character number
    hattingen = groups[13].first
    assert_equal('Hattingen', hattingen.shortname)
    assert_equal('2769510000100', hattingen.number)
  end

  def test_some
    assert_equal('PASSAU DONAU', @stations[23].shortname)
    assert_equal('PASSAU DONAU', @stations[23].longname)
  end
end
