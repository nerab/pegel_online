require 'helper'

class TestCommandStation < IntegrationTest
  def test_station
    out, err = assert_command('Konstanz').map{|s| s.split("\n")}
#    out = assert_command('station')
    refute_empty(out, "Expected '#{name}' to produce an non-empty output")

    expected = [
      'KONSTANZ (km 0.0 of BODENSEE)',
      'TODO: Measurement',
    ]

    assert_equal(expected, out)
  end

  def test_water
    out, err = assert_command('Elbe').map{|s| s.split("\n")}
    refute_empty(out, "Expected '#{name}' to produce an non-empty output")
    assert_equal(5, out.size)

    expected = [
      'HAVELBERG EP',
      'HAVELBERG UP',
      'HEIDELBERG UP',
      'HAVELBERG STADT',
      'ELBE (ARTLENBURG)',
    ]

    assert_equal(expected, out)
  end
end
