require_relative '../helper'

class TestCommandLineInterface < IntegrationTest
  def test_unknown_station
    out, err = assert_command('station Nonexisting', 1).map{|s| s.split("\n")}
    assert_empty(err)
    assert_empty(out)
  end

  def test_unknown_station_verbose
    out, err = assert_command('station Unknown', 1, verbose: true).map{|s| s.split("\n")}
    assert_equal(["No results found."], err)
    assert_empty(out)
  end

  def test_stations_verbose
    out, err = assert_command('station', 0, verbose: true).map{|s| s.split("\n")}
    assert_equal(["Found 606 results:"], err)
  end

  def test_station_verbose
    out, err = assert_command('station Pirna', 0, verbose: true).map{|s| s.split("\n")}
    assert_equal(["Found station:"], err)
    assert_equal(['PIRNA (km 34.67 of ELBE)'], out)
  end

  def test_station_uuid
    out, err = assert_command('station Koblenz', 0, uuid: true).map{|s| s.split("\n")}
    assert_equal(["4c7d796a-39f2-4f26-97a9-3aad01713e29"], out)
  end

  def test_station
    out, err = assert_command('station Konstanz').map{|s| s.split("\n")}
    refute_empty(out, "Expected '#{name}' to produce an non-empty output")
    assert_equal(['KONSTANZ'], out)
  end

  def test_station_many
    out, err = assert_command('station Elbe').map{|s| s.split("\n")}
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

  def test_trailing_slash
    out, err = assert_command('station Konstanz', 0, url: server.url.to_s.chomp('/')).map{|s| s.split("\n")}
    refute_empty(out, "Expected '#{name}' to produce an non-empty output")
    assert_equal(['KONSTANZ'], out)
  end

  def test_timeout
    out, err = refute_command('station Elbe', 1, url: 'http://localhost').map{|s| s.split("\n")}
    assert_empty(out, "Expected '#{name}' to produce an empty output")
    assert_equal(['Error: Retrieval of http://localhost/stations.json?ids=Elbe timed out.'], err)
  end

  def test_unknown_host
    # http://www.exampl.co
  end

  def test_url_not_found
    # http://www.example.com
  end

  def test_station_many_verbose
    out, err = assert_command('station Elbe', 0, verbose: true).map{|s| s.split("\n")}
    refute_empty(out, "Expected '#{name}' to produce an non-empty output")
    assert_equal(5, out.size)

    expected = [
      'HAVELBERG EP (km 147.305 of UNTERE HAVEL-WASSERSTRASSE)',
      'HAVELBERG UP (km 146.89 of UNTERE HAVEL-WASSERSTRASSE)',
      'HEIDELBERG UP (km 26.5 of NECKAR)',
      'HAVELBERG STADT (km 145.29 of UNTERE HAVEL-WASSERSTRASSE)',
      'ELBE (ARTLENBURG) (km 114.74 of ELBESEITENKANAL)',
    ]

    assert_equal(expected, out)
  end
end
