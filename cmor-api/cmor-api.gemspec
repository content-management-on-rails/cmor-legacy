require_relative "lib/cmor/api/version"

Gem::Specification.new do |spec|
  spec.name        = "cmor-api"
  spec.version     = Cmor::Api::VERSION
  spec.authors     = ["BeeGood IT"]
  spec.email       = ["info@beegoodit.de"]
  spec.homepage    = "https://github.com/content-management-on-rails/cmor"
  spec.summary     = "Core API module for CMOR."
  
  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/content-management-on-rails/cmor"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0.2.4"
  spec.add_development_dependency "factory_bot_rails"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "pry-rails"
  spec.add_development_dependency "rspec-rails"
end
