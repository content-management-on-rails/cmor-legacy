$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require_relative "../lib/cmor/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'cmor_user_area_backend'
  s.version     = ::Cmor::VERSION
  s.authors     = ['Roberto Vasquez Angel']
  s.email       = ['roberto@vasquez-angel.de']
  s.homepage    = 'https://github.com/robotex82/cmor_user_area2_backend'
  s.summary     = 'Backend Module for CMOR User Area'
  s.description = 'Provides a ITSF Backend based Backend for CMOR User Area'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'rails', '>= 5.0.0'
  s.add_dependency 'cmor_core_backend', "= #{Cmor::VERSION}"
  s.add_dependency 'cmor_user_area', "= #{Cmor::VERSION}"

  s.add_development_dependency 'therubyracer'
  s.add_development_dependency 'rails-dummy'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'i18n-debug'

  s.add_development_dependency 'guard-bundler'
  s.add_development_dependency 'guard-rails'
  s.add_development_dependency 'rubocop'
end
