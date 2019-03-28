$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require_relative "../lib/cmor/version"
require_relative "../cmor_core/lib/cmor/core/gemspec"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  Cmor::Core::Gemspec.defaults(s)
  s.name        = 'cmor_tags'
  s.summary     = 'CMOR Tags Module'
  s.description = 'CMOR Tags Module'

  s.files = Dir['{app,config,db,lib,spec}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.add_dependency 'acts-as-taggable-on'
  s.add_dependency 'rao-service', '>= 0.0.16.pre'
  s.add_dependency 'rao-service_controller', '>= 0.0.16.pre'
  s.add_dependency 'responders'
end
