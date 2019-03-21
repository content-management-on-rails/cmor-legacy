$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require_relative "../lib/cmor/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cmor_blog_backend"
  s.version     = ::Cmor::VERSION
  s.authors     = ["Roberto Vasquez Angel"]
  s.email       = ["roberto@vasquez-angel.de"]
  s.homepage    = "https://github.com/content-management-on-rails"
  s.summary     = "Cmor::Blog::Backend."
  s.description = "Cmor::Blog::Backend Module."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails"
  s.add_dependency "cmor_blog", "= #{Cmor::VERSION}"
  s.add_dependency "rao-query"

  s.add_development_dependency 'sqlite3', '~> 1.3.6'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'rails-dummy'
  s.add_development_dependency 'rao-shoulda_matchers'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_bot_rails'
end
