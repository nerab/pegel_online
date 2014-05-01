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

* Enhance the command line program to present additional information

* Two ways to load measurements:

  1. Lazy (on an existing Station instance):

        http://www.pegelonline.wsv.de/webservices/rest-api/v2/stations/KETZIN/W.json?includeCurrentMeasurement=true

    Or just the current measurement, based on the UUID:

        http://www.pegelonline.wsv.de/webservices/rest-api/v2/stations/c203d5fb-96d7-4643-b2ef-b13b1d88c75b/W/currentmeasurement.json

  1. Include the measurements when finding the station:

        Station.find_by(:name => 'FLENSBURG', :include => :measurements)

    Include should work for

      * :timeseries
      * :measurement
      * :characteristic_values

  Same should work for Water instances, too. By default we find a water without its stations, but with `:include`, the stations will be loaded in one coarse-grained HTTP call.
