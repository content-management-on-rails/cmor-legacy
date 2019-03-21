$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require_relative "../lib/cmor/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cmor_files"
  s.version     = ::Cmor::VERSION
  s.authors     = ["Roberto Vasquez Angel"]
  s.email       = ["roberto@vasquez-angel.de"]
  s.homepage    = "https://github.com/content-management-on-rails"
  s.summary     = "Cmor Files Module."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib,spec}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 5.2.0"
  s.add_dependency "acts_as_published"
  s.add_dependency "cmor_core", "= #{Cmor::VERSION}"
  s.add_dependency "rao-resources_controller"
  s.add_dependency "rao-component"

  s.add_development_dependency "sqlite3", '~> 1.3.6'
  s.add_development_dependency "responders"

  s.add_development_dependency 'capybara'
  s.add_development_dependency 'factory_bot_rails'
  s.add_development_dependency 'guard-bundler'
  s.add_development_dependency 'guard-rails'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'pry-rails'
  s.add_development_dependency 'rao-shoulda_matchers'
  s.add_development_dependency 'rails-dummy'
  s.add_development_dependency 'rails-i18n'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'shoulda-matchers'
end
