require 'bundler/gem_tasks'
require 'rake/testtask'
require_relative 'test/lib/server'

namespace :test do
  Rake::TestTask.new(:unit) do |test|
    test.libs << 'lib' << 'test' << 'test/unit'
    test.pattern = 'test/unit/test_*.rb'
  end

  Rake::TestTask.new(:integration) do |test|
    test.libs << 'lib' << 'test' << 'test/integration'
    test.pattern = 'test/integration/test_*.rb'
  end
end

task :default => :'test:unit'
