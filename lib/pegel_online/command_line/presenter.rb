module PegelOnline
  module WaterPresenter
    def present
      yield longname.capitalize
    end
  end

  module StationPresenter
    def present
      w = nil
      water.extend(WaterPresenter).present do |p|
        w = p
      end

      yield "#{longname.capitalize} (km #{km} of #{w})"
    end
  end
end
