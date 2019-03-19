$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require_relative "../lib/cmor/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'cmor_tags'
  s.version     = Cmor::VERSION
  s.authors     = ['Roberto Vasquez Angel']
  s.email       = ['roberto@vasquez-angel.de']
  s.homepage    = 'https://github.com/robotex82/cmor_tags'
  s.summary     = 'Easy tagging for itsf backend'
  s.description = 'ECM Tags Module'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib,spec}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.add_dependency 'rails'
  s.add_dependency 'acts-as-taggable-on'
  s.add_dependency 'haml-rails'
  # s.add_dependency 'responders'
  s.add_dependency 'simple_form'

  s.add_development_dependency 'capybara'
  s.add_development_dependency 'formulaic'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'shoulda-matchers'

  s.add_development_dependency 'guard-bundler'
  s.add_development_dependency 'guard-rails'
  s.add_development_dependency 'guard-rspec'

  s.add_development_dependency 'rails-dummy'
  s.add_development_dependency 'sqlite3'
end
