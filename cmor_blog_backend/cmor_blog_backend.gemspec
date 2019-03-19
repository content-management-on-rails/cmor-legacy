$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "cmor/blog/backend/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cmor_blog_backend"
  s.version     = Cmor::Blog::Backend::VERSION
  s.authors     = ["Roberto Vasquez Angel"]
  s.email       = ["roberto@vasquez-angel.de"]
  s.homepage    = "https://github.com/robotex82/cmor_blog_backend"
  s.summary     = "Cmor::Blog::Backend."
  s.description = "Cmor::Blog::Backend Module."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails"
  s.add_dependency "cmor_blog"
  s.add_dependency "rao-query"
end
