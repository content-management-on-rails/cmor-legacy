$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require_relative "../lib/cmor/version"
require_relative "../cmor_core/lib/cmor/core/gemspec"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  Cmor::Core::Gemspec.defaults(s)
  s.name        = 'cmor_cms'
  s.summary     = 'CMS base module for ruby on rails.'
  s.description = 'CMS base module for ruby on rails.'

  s.files = Dir['{app,config,db,lib}/**/*', 'spec/factories/**/*'] + ['MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.add_dependency 'awesome_nested_set'
  s.add_dependency 'coffee-rails'
  s.add_dependency 'draper'
  s.add_dependency 'rao-service', '>= 0.0.17.pre'
  s.add_dependency 'RedCloth'
  s.add_dependency 'simple-navigation', '>= 4.0.0'
end
