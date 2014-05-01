module PegelOnline
  Timeout = Class.new(StandardError)
  Error = Class.new(StandardError)

  def retrieve_stations(options = {})
    #?includeTimeseries=true&includeCurrentMeasurement=true
    retrieve('http://www.pegelonline.wsv.de/webservices/rest-api/v2/stations.json')
  end

  def retrieve_waters(options = {})
    retrieve('http://www.pegelonline.wsv.de/webservices/rest-api/v2/waters.json')
  end

  def retrieve(url)
    request = Typhoeus::Request.new(url, followlocation: true)

    request.on_complete do |response|
      if response.success?
        return response.body
      elsif response.timed_out?
        raise Timeout
      else
        raise Error, response.code
      end
    end

    request.run
  end
end
