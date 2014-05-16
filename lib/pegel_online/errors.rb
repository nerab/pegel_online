require 'typhoeus'
require 'uri'
require 'cgi'

module PegelOnline
  module ClientError
    Timeout = Class.new(StandardError) do
      def initialize(url)
        super("Retrieval of #{url} timed out.")
      end
    end

    General = Class.new(StandardError) do
      def initialize(url, response)
        super("Retrieval of #{url} failed: #{response.return_message}.")
      end
    end
  end

  module ServerError
    def self.find(code)
      constants.each do |const|
        clazz = const_get(const)

        return clazz if clazz.respond_to?(:code) && clazz.code == code
      end

      General
    end

    NotFound = Class.new(StandardError) do
      def initialize(url, _)
        super("The server could not find #{url}.")
      end

      def self.code
        404
      end
    end

    General = Class.new(StandardError) do
      def initialize(url, response)
        super("Retrieval of #{url} failed with status #{response.code}.")
      end
    end
  end

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
end
