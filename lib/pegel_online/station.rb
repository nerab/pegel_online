module PegelOnline
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
        JSON.parse(PegelOnline.retrieve_stations(options)).map do |json|
          StationMapper.map(json)
        end
      end

      def find_by(options = {})
        [JSON.parse(PegelOnline.retrieve_stations(:by => options))].map do |json|
          StationMapper.map(json)
        end
      end

      def find(*numbers_or_uuids)
        ids = Array(numbers_or_uuids)

        result = JSON.parse(PegelOnline.retrieve_stations(ids)).map do |json|
          StationMapper.map(json)
        end

        if 1 == ids.size # asked for one, get one
          result.first
        else
          result
        end
      end
    end
  end
end
