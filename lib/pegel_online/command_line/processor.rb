module PegelOnline
  module CommandLine
    module Processor
      MissingArgument = Class.new(StandardError) do
        def initialize
          super("Missing argument.")
        end
      end

      def self.present(stations, presenter = PegelOnline::StationPresenter)
        STDERR.puts "#{stations.size} results:"

        stations.each do |s|
          s.extend(presenter)
          s.present do |p|
            STDOUT.puts p
          end
        end
      end

      def self.invoke(args)
        raise MissingArgument if args.empty?
        query = args.first

        case query
          when /[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12}/
            # uuid
            present Station.find(query)
          when /\d{3,13}/
            # number
            present Station.find(query)
          else
            # treat it as name
            present Station.find_by(name: query)
        end
      end
    end
  end
end
