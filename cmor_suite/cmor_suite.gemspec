$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require_relative "../lib/cmor/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cmor_suite"
  s.version     = Cmor::VERSION
  s.authors     = ["Roberto Vasquez Angel"]
  s.email       = ["roberto@vasquez-angel.de"]
  s.summary     = "Easy Content Management Suite."
  s.description = "Modular, scalable content management on rails."
  s.license     = "MIT"

  s.files = Dir["{lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency 'rails'
  s.add_dependency 'cmor'

  s.add_dependency 'cmor_blog'
  s.add_dependency 'cmor_blog_backend'

  s.add_dependency 'cmor_carousels'
  s.add_dependency 'cmor_carousels_backend'

  s.add_dependency 'cmor_cms2'
  s.add_dependency 'cmor_cms2_backend'

  s.add_dependency 'cmor_contact2'
  s.add_dependency 'cmor_contact2_backend'

  s.add_dependency 'cmor_files'
  s.add_dependency 'cmor_files_backend'

  s.add_dependency 'cmor_galleries'
  s.add_dependency 'cmor_galleries_backend'

  s.add_dependency 'cmor_links2'
  s.add_dependency 'cmor_links2_backend'

  s.add_dependency 'cmor_rbac'
  s.add_dependency 'cmor_rbac_backend'

  s.add_dependency 'cmor_tags'
  s.add_dependency 'cmor_tags_backend'

  s.add_dependency 'cmor_user_area2'
  s.add_dependency 'cmor_user_area2_backend'

  s.add_development_dependency 'sqlite3', "~> 1.3.6"
  s.add_development_dependency 'responders'

  s.add_development_dependency 'capybara'
  s.add_development_dependency 'factory_bot_rails'
  s.add_development_dependency 'git_log_generator'
  s.add_development_dependency 'guard-bundler'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'i18n-debug'
  s.add_development_dependency 'pry-rails'
  s.add_development_dependency 'puma'
  s.add_development_dependency 'rails-dummy'
  s.add_development_dependency 'rao-shoulda_matchers'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'simplecov'
end
