# pegel_online

Wrapper around the [PegelOnline REST API](http://www.pegelonline.wsv.de/webservice/dokuRestapi).

## Installation

Add this line to your application's Gemfile:

    gem 'pegel_online'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pegel_online

## Usage

### Station

    # all stations
    pegel station

    # station by name
    pegel station Koblenz

    # two stations by name
    pegel station Koblenz Konstanz

    # station by number
    pegel station 501110

    # station by uuid of the station)
    pegel station 593647aa-9fea-43ec-a7d6-6476a76ae868

    # all stations of a water
    pegel station --water=Elbe

    # all stations of two waters
    pegel station --water=Elbe --water=Rhein

    # station by name (number, uuid) including the current measurement
    pegel station Koblenz --include-current-measurement

    # station by name (number, uuid) including its characteristic values
    pegel station Koblenz --include-characteristic-values

### Water

    # all waters
    pegel water

    # all waters including their stations
    pegel water --include-stations

    # all waters including their current measurement (implies --include-stations)
    pegel water --include-current-measurement

    # all waters including their characteristic values (implies --include-stations)
    pegel water --include-characteristic-values

    # water by name
    pegel water Elbe

    # water by name and only the stations listed
    pegel water Elbe --station Pirna --station Dresden

    # two waters by name
    pegel water Rhein Donau

### Measurement
### Timeseries
### CurrentMeasurement

# Tests

The integration tests are, albeit using a local API server, quite heavy. That's why they are in their own (guard) group. The can be started with either

    guard --group integration

or

    rake test:integration
