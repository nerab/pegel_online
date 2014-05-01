require 'helper'

class TestStationFinders < MiniTest::Test
  def test_find_nil
    assert_raises(MissingFindBy) do
      Station.find_by(nil)
    end
  end

  def test_find_empty
    assert_raises(EmptyFindBy) do
      Station.find_by('')
    end
  end

  def test_find_by_uuid
    results = mocked do
      Station.find_by(:uuid => '16b9b4e7-be14-41fd-941e-6755c97276cc')
    end

    assert_kind_of(Array, results)
    assert_equal(1, results.size)
    muehlberg = results.first
    refute_nil(muehlberg)
    assert_equal('501160', muehlberg.number)
  end

  def test_find_by_number
    results = mocked do
      Station.find_by(number: '501110')
    end

    assert_kind_of(Array, results)
    assert_equal(1, results.size)
    riesa = results.first
    refute_nil(riesa)
    assert_equal('b04b739d-7ffa-41ee-9eb9-95cb1b4ef508', riesa.uuid)
  end

  def test_find_uuid
    uelzen_ow = mocked do
       Station.find('728bd3e3-23f2-41c6-8ac5-4cfa223a5a7e')
    end

    refute_nil(uelzen_ow)
    assert_equal('90100111', uelzen_ow.number)
  end

  def test_find_uuid_multi
    skip
  end

  def test_find_number
    skip
  end

  def test_find_number_multi
    skip
  end
end
