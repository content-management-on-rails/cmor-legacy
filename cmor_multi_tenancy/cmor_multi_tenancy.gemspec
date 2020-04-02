$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "cmor/multi_tenancy/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "cmor_multi_tenancy"
  spec.version     = Cmor::MultiTenancy::VERSION
  spec.authors     = ["Roberto Vasquez Angel"]
  spec.email       = ["roberto@vasquez-angel.de"]
  spec.homepage    = "https://content-management-on-rails/cmor"
  spec.summary     = "Cmor::MultiTenancy Module."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = 'https://rubygems.com'
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  # Defaults
  spec.add_dependency "rails", ">= 5.2.0"
  spec.add_dependency "cmor", "= 0.0.53.pre"
  spec.add_dependency "cmor_core_backend", "= 0.0.53.pre"
  spec.add_dependency "request_store"
  spec.add_dependency "rao-service"

  spec.add_development_dependency "sqlite3", '~> 1.3.6'

  spec.add_development_dependency 'capybara'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'git_log_generator'
  spec.add_development_dependency 'guard-bundler'
  spec.add_development_dependency 'guard-rails'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'pry-rails'
  spec.add_development_dependency 'rails-dummy'
  spec.add_development_dependency 'rails-i18n'
  spec.add_development_dependency 'rao-shoulda_matchers'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'factory_bot_rails' # This has to be after rspec-rails
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'shoulda-matchers'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'simplecov-console'
  spec.add_development_dependency 'puma', '~> 3.11'
  spec.add_development_dependency 'sass-rails', '~> 5.0'
  spec.add_development_dependency 'uglifier', '>= 1.3.0'
  spec.add_development_dependency 'coffee-rails', '~> 4.2'
  spec.add_development_dependency 'bootsnap'
  spec.add_development_dependency 'turbolinks'
  spec.add_development_dependency 'i18n-debug'
end
