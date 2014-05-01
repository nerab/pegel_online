module PegelOnline
  class WaterMapper
    class << self
      def map(json)
        Water.new.tap do |s|
          s.shortname = json['shortname']
          s.longname  = json['longname']
        end
      end
    end
  end

  # shortname  Kurzbezeichnung, maximal 40 Zeichen.
  # longname   Langbezeichnung, maximal 255 Zeichen.
  class Water < Struct.new(:shortname, :longname)
    class << self
      def all
        JSON.parse(PegelOnline.retrieve_waters).map do |json|
          WaterMapper.map(json)
        end
      end
    end
  end
end
