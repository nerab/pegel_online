module PegelOnline
  module WaterPresenter
    def present
      yield longname
    end
  end

  module StationPresenter
    def present
      w = nil
      water.extend(WaterPresenter).present do |p|
        w = p
      end

      yield "#{longname} (km #{km} of #{w})"
    end
  end
end
