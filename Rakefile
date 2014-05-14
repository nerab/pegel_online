require 'bundler/gem_tasks'
require 'rake/testtask'
require_relative 'test/lib/server'

Rake::TestTask.new do |test|
  test.libs << 'lib' << 'test' << 'test/unit'
  test.pattern = 'test/unit/test_*.rb'
end

task :default => :test
