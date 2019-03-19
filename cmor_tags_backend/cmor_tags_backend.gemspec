$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require_relative "../lib/cmor/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'cmor_tags_backend'
  s.version     = ::Cmor::VERSION
  s.authors     = ['Roberto Vasquez Angel']
  s.email       = ['roberto@vasquez-angel.de']
  s.homepage    = 'https://github.com/robotex82/cmor_tags_backend'
  s.summary     = 'CMOR Tags Backend.'
  s.description = 'Backend for the CMOR Tags Module.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.add_dependency 'rails', '>= 5.0.0'
  s.add_dependency 'cmor_core_backend', "= #{Cmor::VERSION}"
  s.add_dependency 'cmor_tags', "= #{Cmor::VERSION}"
end
