* Use OptionParser to set -d or --debug and other flags

* Load measurements:

  1. Include the measurements when finding the station:

        Station.find_by(:name => 'FLENSBURG', :include => :measurements)

    Include should work for

      * :measurement
      * :timeseries
      * :characteristic_values

  Same should work for Water instances, too. By default we find a water without its stations, but with `:include`, the stations will be loaded in one coarse-grained HTTP call (and here, even the measurements are loaded in the same call):

        # Finds all waters named 'Bodensee' and loads stations and their current measurements.
        Water.find_by(:name => 'Bodensee', :include => [:stations, :measurements])

  1. Load the measurement, time series or characteristic values with an existing Station or Water instance:

        # Accepts a Station object or the uuid of a station.
        # For other attributes, use a finder to find the Station before
        # fetching measurements
        Measurement.get(station)

        => http://www.pegelonline.wsv.de/webservices/rest-api/v2/stations/c203d5fb-96d7-4643-b2ef-b13b1d88c75b/W/currentmeasurement.json

  If the Station or Water were loaded without including the measurement, calling Station#measurement will result in an additional HTTP call to fetch the measurement of this station.

* Enhance the command line program to present measurement and other attributes with options.

* Extract UrlBuilder from PegelOnline.retrieve_stations so that it is testable separately.

* Provide finders for stations by

  1. Water

        Station.find_by(:water => 'Elbe')

  1. Radius around coordinates

    http://www.pegelonline.wsv.de/webservices/rest-api/v2/stations.json?latitude=52.44&longitude=13.57&radius=30

        Station.find_by(:latitude => 52.44, :longitude => 13.57, :radius => 30)

* Provide finders for waters by

  1. Short name
  1. Long name

* Compare Station objects by identity (uuid) and equality (all attributes equal, even if the uuid is nil)

* Compare Water objects by equality (short name and long name are equal)

* Exploit the [caching headers](http://www.pegelonline.wsv.de/webservice/dokuRestapi#caching)

* Use [compression](http://www.pegelonline.wsv.de/webservice/dokuRestapi#compression)

* Add static file cache for command line usage
