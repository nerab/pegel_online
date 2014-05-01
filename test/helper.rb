require 'minitest/autorun'
require_relative '../lib/pegel_online'
require 'vcr'

include PegelOnline

VCR.configure do |c|
  c.cassette_library_dir = 'test/fixtures/vcr'
  c.hook_into :typhoeus #:webmock, , :excon, :faraday
end

class MiniTest::Test
  def initialize(name = nil)
      @test_name = name
      super(name) unless name.nil?
  end

  def fixture(name)
    File.read(File.join(File.dirname(__FILE__), 'fixtures', name))
  end

  def mocked(cassette = @test_name, &block)
    VCR.use_cassette("#{self.class.name}_#{cassette}", :record => :new_episodes){block.call}
  end
end
