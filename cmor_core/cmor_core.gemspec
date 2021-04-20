$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require_relative "../lib/cmor/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cmor_core"
  s.version     = ::Cmor::VERSION
  s.authors     = ["Roberto Vasquez Angel"]
  s.email       = ["roberto@vasquez-angel.de"]
  s.homepage    = "https://github.com/content-management-on-rails"
  s.summary     = "Cmor Core Module."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 6.0.0.0"
  s.add_dependency "cmor", "= #{Cmor::VERSION}"
  s.add_dependency 'delayed_job_active_record'
  s.add_dependency 'request_store_rails'
  s.add_dependency 'route_translator'
  s.add_dependency "rao-view_helper", ">= 0.0.20.pre"
  s.add_dependency "kaminari"
  s.add_dependency "bootstrap-kaminari-views"

  s.add_development_dependency "sqlite3", '~> 1.3.6'

  s.add_development_dependency 'capybara'
  s.add_development_dependency 'factory_bot_rails'
  s.add_development_dependency 'guard-bundler'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'i18n-debug'
  s.add_development_dependency 'launchy'
  s.add_development_dependency 'pry-rails'
  s.add_development_dependency 'rails-dummy'
  s.add_development_dependency 'rao-shoulda_matchers'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'shoulda-matchers'
end
