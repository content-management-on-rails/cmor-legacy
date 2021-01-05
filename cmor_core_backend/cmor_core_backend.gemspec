$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require_relative "../lib/cmor/version"
require "cmor/core/backend/gemspec"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  Cmor::Core::Backend::Gemspec.defaults(s)
  s.name        = "cmor_core_backend"
  s.summary     = "Cmor Core Module."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency 'administrador', '>= 0.0.28.pre'
end
