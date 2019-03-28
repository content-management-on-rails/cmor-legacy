$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require_relative "../lib/cmor/version"
require_relative "../cmor_core/lib/cmor/core/gemspec"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  Cmor::Core::Gemspec.defaults(s)
  s.name        = 'cmor_user_area'
  s.summary     = 'CMOR User Area.'
  s.description = 'CMOR User Area.'

  s.files = Dir['{app,config,db,lib,spec}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.add_dependency 'active_model_serializers'
  s.add_dependency 'authlogic'
  s.add_dependency 'bcrypt'
  s.add_dependency 'rao-service', '>= 0.0.16.pre'
  s.add_dependency 'rao-component', '>= 0.0.16.pre'
  s.add_dependency 'rao-resources_controller', '>= 0.0.16.pre'
  s.add_dependency 'simple_form'
end
