$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "<%= name.underscore %>/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "<%= gemspec[:name] %>"
  spec.version     = <%= name %>::VERSION
  spec.authors     = <%= gemspec[:authors] %>
  spec.email       = <%= gemspec[:email] %>
  spec.homepage    = "https://content-management-on-rails/cmor"
  spec.summary     = "<%= name %> Module."
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
  spec.add_dependency "cmor", "= <%= cmor_version %>"
  spec.add_dependency "cmor-core-backend", "= <%= cmor_version %>"

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
end
