$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require_relative "../lib/cmor/version"
require_relative "../cmor-core-backend/lib/cmor/core/backend/gemspec"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  Cmor::Core::Backend::Gemspec.defaults(s)
  s.name = "cmor-system"
  s.summary = "Cmor System Module."

  s.files = Dir["{app,config,db,lib,spec/factories,spec/files}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "markup-rails"
  s.add_dependency "rao-active_collection"

  s.add_development_dependency "delayed_job_active_record"
  s.add_development_dependency "rack-attack"
end
