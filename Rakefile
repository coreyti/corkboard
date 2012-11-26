#!/usr/bin/env rake
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
  exit 1
end

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

desc 'Default: run specs'
task :default => [:spec]

desc 'Run the full spec suite'
task :spec => [:'spec:ruby', :'spec:javascript']

namespace :spec do
  desc 'Run the RSpec code examples'
  RSpec::Core::RakeTask.new(:ruby) do |t|
    t.pattern = "spec/**/*_spec.rb"
    t.verbose = false
  end

  desc 'Run the Jasmine code examples'
  task :javascript do
    system 'cd spec/dummy && rake jasminerice:run'
  end
end
