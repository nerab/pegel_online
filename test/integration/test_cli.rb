require 'helper'

class TestCommandLineInterface < IntegrationTest
  def test_stations_verbose
    out, err = assert_command('station', 0, verbose: true).map{|s| s.split("\n")}
    assert_equal(["Getting all stations:"], err)
  end

  def test_station_verbose
    out, err = assert_command('station Pirna', 0, verbose: true).map{|s| s.split("\n")}
    assert_equal(["Getting station Pirna"], err)
  end

  def test_station
    out, err = assert_command('station Konstanz').map{|s| s.split("\n")}
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
