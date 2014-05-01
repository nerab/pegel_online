* Move to [REST API](http://www.pegelonline.wsv.de/webservice/dokuRestapi)

    http://www.pegelonline.wsv.de/webservices/rest-api/v2/stations.json?includeTimeseries=true&includeCurrentMeasurement=true

  * All waters including all stations:

      http://www.pegelonline.wsv.de/webservices/rest-api/v2/waters.json?includeStations=true&includeTimeseries=true&includeCurrentMeasurement=true

* Exploit the [caching headers](http://www.pegelonline.wsv.de/webservice/dokuRestapi#caching)

* Use [compression](http://www.pegelonline.wsv.de/webservice/dokuRestapi#compression)

* Rename Level to Station

* Rename Waterway to Water

* Refer to levels by UUID and provide finders by

  1. Name
  1. Station number
  1. Short name
  1. Long name
  1. Water
  1. Radius around coordinates

    http://www.pegelonline.wsv.de/webservices/rest-api/v2/stations.json?latitude=52.44&longitude=13.57&radius=30

* Static file cache for command line usage
* Expose finders on command line
