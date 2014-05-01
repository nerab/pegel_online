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

  class StationMapper
    class << self
      def map(json)
        Station.new.tap do |s|
          s.uuid       = json['uuid']
          s.number     = json['number']
          s.shortname  = json['shortname']
          s.longname   = json['longname']
          s.km         = json['km']
          s.agency     = json['agency']
          s.longitude  = json['longitude']
          s.latitude   = json['latitude']
          s.water = WaterMapper.map(json['water'])
        end
      end
    end
  end

  # uuid       Eindeutige unveränderliche ID.
  # number     Pegelnummer
  # shortname  Pegelname (max. 40 Zeichen)
  # longname   Pegelname (max. 255 Zeichen)
  # km         Flusskilometer
  # agency     Wasser- und Schifffahrtsamt
  # longitude  Längengrad in WGS84 Dezimalnotation
  # latitude   Breitengrad in WGS84 Dezimalnotation
  # water      Angaben zum Gewässer
  class Station < Struct.new(:uuid, :number, :shortname, :longname, :km, :agency, :longitude, :latitude, :water)
    class << self
      def all(options = {})
        JSON.parse(retrieve_stations(options)).map do |json|
          StationMapper.map(json)
        end
      end
    end
  end

  # shortname  Kurzbezeichnung, maximal 40 Zeichen.
  # longname   Langbezeichnung, maximal 255 Zeichen.
  class Water < Struct.new(:shortname, :longname)
    class << self
      def all
        JSON.parse(retrieve_waters).map do |json|
          WaterMapper.map(json)
        end
      end
    end
  end
end
