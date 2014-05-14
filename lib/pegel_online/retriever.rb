require 'typhoeus'
require 'uri'
require 'cgi'

module PegelOnline
  Timeout = Class.new(StandardError)
  Error = Class.new(StandardError)

  UnknownFindBy = Class.new(StandardError) do
    def initialize(unknown)
      super("The query operator '#{unknown}' is not supported.")
    end
  end

  UnsupportedBy = Class.new(StandardError)
  EmptyFindBy = Class.new(StandardError)

  MissingFindBy = Class.new(StandardError) do
    def initialize
      super('The mandatory option :by is missing')
    end
  end

  def self.retrieve_stations(options = {})
    url = URI(endpoint)

    # TODO
    # if tmp = Array.try_convert(arg)
    #   # the argument is an array
    # elsif tmp = String.try_convert(arg)
    #   # the argument is a string
    # end

    if options.nil? || options.empty?
      url.path << 'stations.json'
    elsif String === options
      url.path << "stations/#{options}.json"
    elsif Array === options
      url.path << 'stations.json'
      url.query = "ids=#{CGI.escape(options.join(','))}"
    elsif options[:by]
      raise UnsupportedBy if 1 < options[:by].size
      raise EmptyFindBy if options[:by].empty?

      key = options[:by].keys.first

      if :uuid == key || :number == key
        url.path <<  "stations/#{options[:by].values.first}.json"
      elsif :name == key
        url.path << 'stations.json'
        url.query = "fuzzyId=#{CGI.escape(options[:by].values.first)}"
      elsif :water == key
        url.path << 'stations.json'
        url.query = "waters=#{CGI.escape(options[:by].values.first)}"
      else
        raise UnknownFindBy.new(key)
      end
    else
      raise MissingFindBy
    end

    # if with = options[:with] && :measurement == with
    #   url << '?includeCurrentMeasurement=true'
    # end

    # if with = options[:with] && :timeseries == with
    #   url << '?includeTimeseries=true'
    # end

    retrieve(url)
  end

  def self.retrieve_waters(options = {})
    url = URI(endpoint)
    url.path << 'waters.json'
    retrieve(url)
  end

  def self.retrieve(url)
    request = Typhoeus::Request.new(url.to_s, followlocation: true)

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
