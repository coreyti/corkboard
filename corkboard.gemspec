$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "corkboard/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "corkboard"
  s.version     = Corkboard::VERSION
  s.authors     = ["Corey Innis"]
  s.email       = ["corey@coolerator.net"]
  s.homepage    = "https://github.com/fullandby/corkboard"
  s.summary     = "Dashboard composed of social network posts."
  s.description = "Dashboard composed of social network posts."

  s.files       = `git ls-files`.split($\)
  s.executables = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files  = s.files.grep(%r{^(test|spec|features)/})

  s.add_dependency "rails", "~> 3.2.8"
  s.add_dependency "jquery-rails"
  s.add_dependency "redis"
  s.add_dependency "weighted_randomizer"
  s.add_dependency "pusher"
  s.add_dependency "instagram"
  s.add_dependency "omniauth"
  s.add_dependency "omniauth-oauth2"
  s.add_dependency "omniauth-instagram"

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "capybara-webkit"
  s.add_development_dependency "ffaker"
  s.add_development_dependency "jasmine"
  s.add_development_dependency "jasminerice"
  s.add_development_dependency "jasminerice-runner"
  s.add_development_dependency "mock_redis"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "yard"
  s.add_development_dependency "yard-rails"
end
