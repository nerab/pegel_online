require 'helper'

class TestStation < MiniTest::Test
  def setup
    @konstanz = Station.new
    @konstanz.uuid      = 'aa9179c1-17ef-4c61-a48a-74193fa7bfdf'
    @konstanz.number    = '906'
    @konstanz.shortname = 'KONSTANZ'
    @konstanz.longname  = 'KONSTANZ'
    @konstanz.km        = 0.0
    @konstanz.agency    = 'REGIERUNGSPRÄSIDIUM FREIBURG'
    @konstanz.longitude = 9.172833233102148
    @konstanz.latitude  = 7.66789422885012
    @konstanz.water = Water.new('BODENSEE', 'BODENSEE')
  end

  def test_empty
    s = Station.new
    refute_nil(s)
  end

  def test_attributes
    refute_nil(@konstanz)
    assert_equal('aa9179c1-17ef-4c61-a48a-74193fa7bfdf', @konstanz.uuid)
    assert_equal('906', @konstanz.number)
    assert_equal('KONSTANZ', @konstanz.shortname)
    assert_equal('KONSTANZ', @konstanz.longname)
    assert_equal(0.0, @konstanz.km)
    assert_equal('REGIERUNGSPRÄSIDIUM FREIBURG', @konstanz.agency)
    assert_equal(9.172833233102148, @konstanz.longitude)
    assert_equal(7.66789422885012, @konstanz.latitude)
    assert_equal(Water.new('BODENSEE', 'BODENSEE'), @konstanz.water)
  end
end
