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
        station.extend(StationPresenter).present(options) do |sp|
          yield sp
        end
      end
    end
  end

  #
  # Presents a single station
  #
  module StationPresenter
    def present(options = {})
      if options[:uuid]
        yield uuid
      else
        water_presentation = nil
        water.extend(WaterPresenter).present do |p|
          water_presentation = p
        end

        if options[:verbose]
          yield "#{longname} (km #{km} of #{water_presentation})"
        else
          yield longname
        end

        yield "TODO: Measurement" if options[:measurement]
      end
    end
  end
end
