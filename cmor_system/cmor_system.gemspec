$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require_relative "../lib/cmor/version"
require_relative "../cmor_core_backend/lib/cmor/core/backend/gemspec"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  Cmor::Core::Backend::Gemspec.defaults(s)
  s.name        = "cmor_system"
  s.summary     = "Cmor System Module."

  s.files = Dir["{app,config,db,lib,spec}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  # s.add_dependency 'cmor_tags', "= #{Cmor::VERSION}"
  s.add_dependency 'markup-rails'

  s.add_development_dependency 'delayed_job_active_record'
end
