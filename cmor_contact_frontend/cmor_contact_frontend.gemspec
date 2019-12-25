$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require_relative "../lib/cmor/version"
require_relative "../cmor_core_frontend/lib/cmor/core/frontend/gemspec"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  Cmor::Core::Frontend::Gemspec.defaults(s)
  s.name        = "cmor_contact_frontend"
  s.homepage    = "https://github.com/content-management-on-rails/cmor"
  s.summary     = "Cmor Contact Frontend Module."

  s.files = Dir["{app,config,db,lib,spec}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency 'cmor_contact'
  s.add_dependency 'responders'
  # s.add_dependency 'haml-rails'
  # s.add_dependency 'simple_form'
  # s.add_dependency 'coffee-rails'
end
