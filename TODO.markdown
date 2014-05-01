* Lookup Water and Stations objects by UUID

* Provide finders for stations by

  1. Name
  1. Station number
  1. Short name
  1. Long name
  1. Water
  1. Radius around coordinates

    http://www.pegelonline.wsv.de/webservices/rest-api/v2/stations.json?latitude=52.44&longitude=13.57&radius=30

* Provide finders for waters by

  1. Short name
  1. Long name

* Compare Water and Stations objects by identity (uuid) and equality (all attributes equal, even if the uuid is nil)

* Exploit the [caching headers](http://www.pegelonline.wsv.de/webservice/dokuRestapi#caching)

* Use [compression](http://www.pegelonline.wsv.de/webservice/dokuRestapi#compression)

* Add static file cache for command line usage

* Expose finders on the command line
