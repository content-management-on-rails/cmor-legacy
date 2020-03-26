$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require_relative "../lib/cmor/version"
require_relative "../cmor_core_frontend/lib/cmor/core/frontend/gemspec"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cmor_testimonials"
  Cmor::Core::Frontend::Gemspec.defaults(s)
  s.authors     = ["Eugen Müller", "Roberto Vasquez Angel"]
  s.summary     = "CMOR Testimonials Module."
  s.description = "CMOR Testimonials Module."

  s.files = Dir["{app,config,db,lib,spec/factories,spec/files}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  # Engine dependencies
  s.add_dependency 'acts_as_list'
  s.add_dependency 'markup-rails'
  s.add_dependency 'acts_as_published'
  s.add_dependency 'friendly_id'
  s.add_dependency 'haml-rails'
  s.add_dependency 'mini_magick'
  s.add_dependency 'rao-view_helper', '>= 0.0.19.pre'
end

