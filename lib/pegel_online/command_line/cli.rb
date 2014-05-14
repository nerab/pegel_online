require 'thor'

module PegelOnline
  module CommandLine
    class CLI < Thor
      class_option :verbose, :type => :boolean
      class_option :url

      desc 'station [NAME | NUMBER | UUID]', 'Get all stations. If present, get only those matching NAME, NUMBER or UUID.'
      def station(name_or_number_or_uuid = nil)
        if name_or_number_or_uuid.nil? || name_or_number_or_uuid.empty?
          STDERR.puts "Getting all stations:" if options[:verbose]
        else
          STDERR.puts "Getting station #{name_or_number_or_uuid}" if options[:verbose]
        end
      end
    end
  end
end
