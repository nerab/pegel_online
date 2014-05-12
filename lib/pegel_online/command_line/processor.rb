module PegelOnline
  module CommandLine
    module Processor
      MissingArgument = Class.new(StandardError) do
        def initialize
          super("Missing argument. Station is required.")
        end
      end

      def self.present(stations, options = {})
        case stations
          when NilClass
            STDERR.puts("No results found.")
          when Station
            stations.extend(PegelOnline::StationPresenter).present(options) do |p|
              STDOUT.puts p
            end
          when Array
            if stations.empty?
              STDERR.puts("No results found.")
            else
              STDERR.puts("Found #{stations.size} results:")
              stations.extend(PegelOnline::StationsPresenter).present(options) do |p|
                STDOUT.puts p
              end
            end
          else
            raise "No presenter available for #{stations}"
        end
      end

      def self.invoke(args, options = {})
        if args.empty?
          if options[:all_waters]
            STDERR.puts("All waters:")
            present(Water.all, options)
          else
            if options[:water]
              present(Station.find_by(water: options[:water]), options)
            else
              STDERR.puts("All stations:")
              present(Station.all, options)
            end
          end
        else
          query = args.first # TODO Support multiple stations

          case query
            when /[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12}/
              present(Station.find(query), options)
            when /\d{3,13}/
              present(Station.find_by(number: query), options)
            else
              present(Station.find(query) || Station.find_by(name: query), options)
          end
        end
      end
    end
  end
end
