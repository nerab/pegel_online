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

  def test_find_number
    riesa = mocked do
      Station.find('501110')
    end

    refute_nil(riesa)
    assert_equal('b04b739d-7ffa-41ee-9eb9-95cb1b4ef508', riesa.uuid)
  end

  def test_find_number_multi
    results = mocked do
      Station.find('501110', '503050', '586310')
    end

    assert_kind_of(Array, results)
    assert_equal(3, results.size)

    riesa = results[0]
    refute_nil(riesa)
    assert_equal('b04b739d-7ffa-41ee-9eb9-95cb1b4ef508', riesa.uuid)

    wittenberge = results[1]
    refute_nil(wittenberge)
    assert_equal('cbf3cd49-91bd-49cc-8926-ccc6c0e7eca4', wittenberge.uuid)

    wendisch_rietz_op = results[2]
    refute_nil(wendisch_rietz_op)
    assert_equal('a9299f0c-9eb8-4369-a260-4be929e72736', wendisch_rietz_op.uuid)
  end

  def test_find_uuid
    uelzen_ow = mocked do
       Station.find('728bd3e3-23f2-41c6-8ac5-4cfa223a5a7e')
    end

    refute_nil(uelzen_ow)
    assert_equal('90100111', uelzen_ow.number)
  end

  def test_find_uuid_multi
    results = mocked do
      Station.find('b04b739d-7ffa-41ee-9eb9-95cb1b4ef508', 'cbf3cd49-91bd-49cc-8926-ccc6c0e7eca4', 'a9299f0c-9eb8-4369-a260-4be929e72736')
    end

    assert_kind_of(Array, results)
    assert_equal(3, results.size)
    assert_equal(['501110', '503050', '586310'], results.map{|r| r.number})
  end

  def test_find_by_name_single_result
    results = mocked do
      Station.find_by(name: 'FLENSBURG')
    end

    assert_kind_of(Array, results)
    assert_equal(1, results.size)
    flensburg = results.first
    refute_nil(flensburg)
    assert_equal('9e19c411-f728-4a43-a057-39d4155c71cc', flensburg.uuid)
  end

  def test_find_by_name_multiple_results
    results = mocked do
      Station.find_by(name: 'burg')
    end

    assert_kind_of(Array, results)
    assert_equal(39, results.size)
  end
end
