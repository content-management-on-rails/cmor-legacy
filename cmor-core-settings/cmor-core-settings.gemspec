$LOAD_PATH.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require_relative "../lib/cmor/version"
require_relative "../cmor-core-backend/lib/cmor/core/backend/gemspec"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  Cmor::Core::Backend::Gemspec.defaults(spec)

  # rubocop:disable Layout/ExtraSpacing
  spec.name        = "cmor-core-settings"
  spec.summary     = "Cmor::Core::Settings."
  spec.description = "Cmor::Core::Settings Module."
  # rubocop:enable Layout/ExtraSpacing

  spec.files = Dir["{app,config,db,lib,spec/factories,spec/files}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rao-active_collection"
end

# $:.push File.expand_path("../lib", __FILE__)
# 
# # Maintain your gem's version:
# require_relative "../lib/cmor/core/settings/version"
# 
# # Describe your gem and declare its dependencies:
# Gem::Specification.new do |s|
#   s.name        = "cmor-core-settings"
#   s.version     = ::Cmor::VERSION
#   s.authors     = ["BeeGood IT"]
#   s.email       = ["info@beegoodit.de"]
#   s.homepage    = "https://github.com/content-management-on-rails"
#   s.summary     = "Cmor Core Settings Module."
#   s.license     = "MIT"
# 
#   s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
# 
#   s.add_dependency "rails", ">= 6.1"
#   s.add_dependency "cmor", "= #{Cmor::VERSION}"
#   s.add_dependency "cmor-core-backend"
# 
#   s.add_development_dependency "sqlite3", '~> 1.4'
# 
#   s.add_development_dependency 'capybara'
#   s.add_development_dependency 'factory_bot_rails'
#   s.add_development_dependency 'guard-bundler'
#   s.add_development_dependency 'guard-rspec'
#   s.add_development_dependency 'i18n-debug'
#   s.add_development_dependency 'launchy'
#   s.add_development_dependency 'pry-rails'
#   s.add_development_dependency 'rails-dummy'
#   s.add_development_dependency 'rao-shoulda_matchers'
#   s.add_development_dependency 'rspec-rails'
#   s.add_development_dependency 'rubocop'
#   s.add_development_dependency 'shoulda-matchers'
#   s.add_development_dependency 'bootsnap'
#   s.add_development_dependency 'webpacker'
# end
# 
