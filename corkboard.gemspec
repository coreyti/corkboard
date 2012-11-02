$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "corkboard/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "corkboard"
  s.version     = Corkboard::VERSION
  s.authors     = ["Corey Innis"]
  s.email       = ["corey@coolerator.net"]
  s.homepage    = "http://fullandby.github.com/corkboard"
  s.summary     = "TODO: Summary of Corkboard."
  s.description = "TODO: Description of Corkboard."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.8"
  s.add_dependency "jquery-rails"
  s.add_dependency "instagram"

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "ffaker"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "yard"
  s.add_development_dependency "yard-rails"
end
