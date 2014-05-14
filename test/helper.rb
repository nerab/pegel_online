require 'minitest/autorun'
require_relative '../lib/pegel_online'
require_relative 'lib/server'

require 'vcr'
require 'open3'
require 'shellwords'

include PegelOnline

VCR.configure do |c|
  c.cassette_library_dir = 'test/fixtures/vcr'
  c.hook_into :typhoeus
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

class IntegrationTest < MiniTest::Test
  BIN_COMMAND = 'bin/pegel'

  def setup
    @server = VCR::Server.new
    @server.start
  end

  def teardown
    @server.stop
  end

  def assert_command(cmd, expected_status = 0, args = {})
    line = "#{command} #{cmd} #{serialize(args)}"
puts "**** Executing: #{line}"
    out, err, status = Open3.capture3(line)
    assert_equal(expected_status, status.exitstatus, "Expected exit status to be #{expected_status}, but it was #{status.exitstatus}. STDERR is: '#{err}'")
    [out, err]
  end

  def refute_command(cmd, expected_status = 1, args = {})
    out, err, status = Open3.capture3("#{command} #{cmd} #{Shellwords.join(default_args.merge(args))}")
    assert_equal(expected_status, status.exitstatus, "Expected exit status to be #{expected_status}, but it was #{status.exitstatus}.")
    [out, err]
  end

  private

  def command
    BIN_COMMAND
  end

  def default_args
    {url: @server.url}
  end

  def serialize(args)
    default_args.merge(args).map{|k,v|
      if v
        "#{k.to_s.shellescape}=#{v.to_s.shellescape}"
      else
        "#{k.to_s.shellescape}"
      end
    }.map{|a| "--#{a}"}.join(' ')
  end
end
