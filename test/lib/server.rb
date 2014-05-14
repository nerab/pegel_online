require 'rack'
require 'rack/handler/webrick'
require 'timeout'

module VCR
  #
  # API Proxy replaying VCR cassettes
  #
  class Server
    attr_reader :url

    def initialize(port = find_available_port, host = '127.0.0.1')
      @url = URI::HTTP.build({:host => host, port: port, path: '/'})
    end

    def start
      @thread = Thread.new do
        Rack::Handler::WEBrick.run(self, :Port => @url.port, :Host => @url.host)
      end
    end

    def stop
      Rack::Handler::WEBrick.shutdown

      timeout(10) do
        @thread.join if @thread
      end
    end

    def call(env)
      # Serve the cassette from information in
      # "PATH_INFO"=>"/stations.json",
      # "QUERY_STRING"=>"ids=station",
      request_uri = URI('http://www.pegelonline.wsv.de/webservices/rest-api/v2')
      request_uri.path += env['PATH_INFO']
      request_uri.query = env['QUERY_STRING']

      response = VCR.use_cassette(cassette_name(request_uri), :record => :once) do
        Typhoeus.get(request_uri.to_s)
      end

      [response.code, response.headers_hash, [response.body]]
    end

  private

    def find_available_port
      server = TCPServer.new('127.0.0.1', 0)
      server.addr[1]
    ensure
      server.close if server
    end

    def cassette_name(request_uri)
      "#{self.class.name}_#{request_uri.to_s.gsub('/', '_').gsub(':', '-')}"
    end
  end
end
