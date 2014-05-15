require 'thor'

module PegelOnline
  module CommandLine
    class CLI < Thor
      class_option :verbose, :type => :boolean
      class_option :url

      desc 'station [NAME | NUMBER | UUID]', 'Get all stations. If present, get only those matching NAME, NUMBER or UUID.'
      method_option :uuid, :type => :boolean, :default => false
      def station(name_or_number_or_uuid = nil)
        if name_or_number_or_uuid.nil? || name_or_number_or_uuid.empty?
          print(Station.all, options)
        else
          case name_or_number_or_uuid
            when /[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89aAbB][a-f0-9]{3}-[a-f0-9]{12}/
              print(Station.find(name_or_number_or_uuid), options)
            when /\d{3,13}/
              print(Station.find_by(number: name_or_number_or_uuid), options)
            else
              print(Station.find(name_or_number_or_uuid) || Station.find_by(name: name_or_number_or_uuid), options)
          end
        end
      end

      private

      def print(stations, options = {})
        case stations
          when NilClass
            STDERR.puts("No results found.") if options[:verbose]
            return 1
          when Station
            STDERR.puts("Found station:") if options[:verbose]
            stations.extend(PegelOnline::StationPresenter).present(options) do |p|
              STDOUT.puts p
            end
          when Array
            if stations.empty?
              STDERR.puts("No results found.") if options[:verbose]
              return 1
            else
              STDERR.puts("Found #{stations.size} results:") if options[:verbose]
              stations.extend(PegelOnline::StationsPresenter).present(options) do |p|
                STDOUT.puts p
              end
            end
          else
            raise "No presenter available for #{stations}"
        end

        0
      end
    end
  end
end
