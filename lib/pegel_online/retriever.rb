module PegelOnline
  Timeout = Class.new(StandardError)
  Error = Class.new(StandardError)
  UnknownFindBy = Class.new(StandardError)
  UnsupportedBy = Class.new(StandardError)
  EmptyFindBy = Class.new(StandardError)

  MissingFindBy = Class.new(StandardError) do
    def initialize
      super('The mandatory option :by is missing')
    end
  end

  def retrieve_stations(options = {})
    url = "http://www.pegelonline.wsv.de/webservices/rest-api/v2/"

    if options.nil? || options.empty?
      url << 'stations.json'
    elsif String === options
      url << "stations/#{options}.json"
    elsif Array === options
      url << "stations.json?ids=#{options.join(',')}"
    elsif options[:by]
      raise UnsupportedBy if 1 < options[:by].size
      raise EmptyFindBy if options[:by].empty?

      key = options[:by].keys.first

      if :uuid == key || :number == key
        url <<  "stations/#{options[:by].values.first}.json"
      else
        raise UnknownFindBy.new(options[:by])
      end
    else
      raise MissingFindBy
    end

    # if with = options[:with] && :measurements == with
    #   url << '?includeTimeseries=true&includeCurrentMeasurement=true'
    # end

    retrieve(url)
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
