module Cmor
  module Core
    module Api
      class Gemspec
        def self.defaults(spec, load_self: true)
          spec.version     = ::Cmor::VERSION
          spec.authors     = ["BeeGood IT"]
          spec.email       = ["info@beegoodit.de"]
          spec.homepage    = "https://github.com/content-management-on-rails"
          spec.license     = "MIT"

          # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
          # to allow pushing to a single host or delete this section to allow pushing to any host.
          spec.metadata["allowed_push_host"] = "https://rubygems.org"

          spec.metadata["homepage_uri"] = spec.homepage
          spec.metadata["source_code_uri"] = "https://github.com/content-management-on-rails/cmor"
          # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

          spec.files = Dir.chdir(File.expand_path(__dir__)) do
            Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
          end

          spec.required_ruby_version = ">= 2.6.0"

          spec.add_dependency "rails", ">= 6.1"
          spec.add_dependency "cmor_core", "= #{Cmor::VERSION}"

          spec.add_dependency "cmor-core-api", "= #{Cmor::VERSION}" if load_self

          spec.add_development_dependency "sqlite3", '~> 1.4.0'
          spec.add_development_dependency "bootsnap"
          spec.add_development_dependency "factory_bot_rails"
          spec.add_development_dependency "guard-rspec"
          spec.add_development_dependency "pry-rails"
          spec.add_development_dependency "rails-dummy"
          spec.add_development_dependency "rspec-rails"
          spec.add_development_dependency "standard"
          spec.add_development_dependency "webpacker"
        end
      end
    end
  end
end