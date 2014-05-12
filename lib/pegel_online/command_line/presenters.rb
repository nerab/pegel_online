module PegelOnline
  module WaterPresenter
    def present(options = {})
      yield longname
    end
  end

  #
  # Presents an Enumerable of stations
  #
  module StationsPresenter
    def present(options = {})
      each do |station|
        if options[:uuid]
          yield station.uuid
        else
          yield station.longname << (options[:verbose] ? " (km #{station.km} of #{station.water.longname})" : '')
        end
      end
    end
  end

  #
  # Presents a single station
  #
  module StationPresenter
    def present(options = {})
      water_presentation = nil
      water.extend(WaterPresenter).present(options) do |p|
        water_presentation = p
      end

      yield "#{longname} (km #{km} of #{water_presentation})"
      yield "TODO: Measurement"
    end
  end
end
