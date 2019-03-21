$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require_relative "../lib/cmor/version"
require_relative "../cmor_core/lib/cmor/core/gemspec"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  Cmor::Core::Gemspec.defaults(s)
  s.name        = "cmor_galleries"
  # s.version     = ::Cmor::VERSION
  # s.authors     = ["Roberto Vasquez Angel"]
  # s.email       = ["roberto@vasquez-angel.de"]
  # s.homepage    = "https://github.com/content-management-on-rails"
  s.summary     = "Cmor Galleries Module."
  # s.license     = "MIT"

  s.files = Dir["{app,config,db,lib,spec}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  # s.add_dependency "rails", ">= 5.2.0"
  # s.add_dependency "cmor_core", "= #{Cmor::VERSION}"
  s.add_dependency "acts_as_list"
  s.add_dependency "acts_as_published"
  # s.add_dependency "rao-resources_controller", '>= 0.0.3.pre'
  # s.add_dependency "rao-view_helper", '>= 0.0.3.pre'

  # s.add_development_dependency "sqlite3"
  # s.add_development_dependency "responders"

  # s.add_development_dependency 'factory_bot_rails'
  # s.add_development_dependency 'pry-rails'
  # s.add_development_dependency 'rails-i18n'
  # s.add_development_dependency 'rubocop'
  # s.add_development_dependency 'rspec-rails'
  # s.add_development_dependency 'shoulda-matchers'
  # s.add_development_dependency 'guard-bundler'
  # s.add_development_dependency 'guard-rails'
  # s.add_development_dependency 'guard-rspec'
end
