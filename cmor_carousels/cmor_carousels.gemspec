$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require_relative "../lib/cmor/version"
require_relative "../cmor_core_frontend/lib/cmor/core/frontend/gemspec"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cmor_carousels"
  Cmor::Core::Frontend::Gemspec.defaults(s)
  s.summary     = "CMOR Module Template."
  s.description = "CMOR Module Template."

  s.files = Dir["{app,config,db,lib,spec}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency 'acts_as_list'
  s.add_dependency 'markup-rails'
  s.add_dependency 'acts_as_published'
  s.add_dependency 'mini_magick'
end

