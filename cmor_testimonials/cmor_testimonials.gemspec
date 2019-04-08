$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require_relative "../lib/cmor/version"
require_relative "../cmor_core/lib/cmor/core/gemspec"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cmor_testimonials"
  Cmor::Core::Gemspec.defaults(s)
  # s.version     = ::Cmor::VERSION
  # s.authors     = ["Eugen M."]
  # s.email       = [""]
  # s.homepage    = "https://github.com/content-management-on-rails"
  s.summary     = "CMOR Module Template."
  s.description = "CMOR Module Template."

  s.files = Dir["{app,config,db,lib,spec}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  # Engine dependencies
  s.add_dependency 'acts_as_list'
  s.add_dependency 'acts_as_markup'
  s.add_dependency 'acts_as_published'
  s.add_dependency 'mini_magick'
  s.add_dependency 'friendly_id'
  s.add_dependency 'haml'
  s.add_dependency 'haml-rails'
end

