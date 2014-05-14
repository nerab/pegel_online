require 'json'

require 'require_all'
require_rel 'pegel_online'

module PegelOnline
  def self.endpoint=(url)
    @url = url
  end

  def self.endpoint
    @url || 'http://www.pegelonline.wsv.de/webservices/rest-api/v2/'
  end
end
