$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require_relative "../lib/cmor/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cmor_carousels"
  s.version     = Cmor::VERSION
  s.authors     = ["Roberto Vasquez Angel"]
  s.email       = ["roberto@vasquez-angel.de"]
  s.homepage    = "https://github.com/robotex82/cmor_carousels"
  s.summary     = "ECM Module Template."
  s.description = "ECM Module Template."

  s.files = Dir["{app,config,db,lib,spec}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  # Engine dependencies
  s.add_dependency 'rails'
  s.add_dependency 'cmor_core'
  s.add_dependency 'acts_as_list'
  s.add_dependency 'acts_as_markup'
  # s.add_dependency 'friendly_id'
  s.add_dependency 'mini_magick'
  # s.add_dependency 'twitter-bootstrap-components-rails'

  s.add_development_dependency "bootsnap"
  s.add_development_dependency "listen"
  s.add_development_dependency "sqlite3", "~> 1.3.6"

  s.add_development_dependency 'factory_bot_rails'
  s.add_development_dependency 'guard-bundler'
  s.add_development_dependency 'guard-rails'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'pry-rails'
  s.add_development_dependency 'rails-i18n'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rubocop-rails_config'
  s.add_development_dependency 'shoulda-matchers'
end

