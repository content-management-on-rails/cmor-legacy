$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require_relative "../lib/cmor/version"
require_relative "../cmor-core-backend/lib/cmor/core/backend/gemspec"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  Cmor::Core::Backend::Gemspec.defaults(s)
  s.name        = 'cmor_links_backend'
  s.summary     = 'Backend Module for CMOR Links'
  s.description = 'Provides a Backend for CMOR Links'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.add_dependency 'cmor_links', "= #{Cmor::VERSION}"
end
