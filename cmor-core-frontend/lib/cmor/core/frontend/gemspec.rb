module Cmor
  module Core
    module Frontend
      class Gemspec
        def self.defaults(s, load_self: true)
          s.version     = ::Cmor::VERSION
          s.authors     = ["BeeGood IT"]
          s.email       = ["info@beegoodit.de"]
          s.homepage    = "https://github.com/content-management-on-rails"
          s.license     = "MIT"

          s.files = Dir["{app,config,db,lib,spec}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

          s.required_ruby_version = ">= 2.6.0"

          s.add_dependency "rails", ">= 6.1"
          s.add_dependency "cmor-core", "= #{Cmor::VERSION}"


          s.add_dependency "cmor-core-frontend", "= #{Cmor::VERSION}"  if load_self

          s.add_development_dependency "sqlite3", '~> 1.4'

          s.add_development_dependency 'capybara'
          s.add_development_dependency 'coveralls'
          s.add_development_dependency 'git_log_generator'
          s.add_development_dependency 'guard-bundler'
          s.add_development_dependency 'guard-rails'
          s.add_development_dependency 'guard-rspec'
          s.add_development_dependency 'pry-rails'
          s.add_development_dependency 'rao-shoulda_matchers'
          s.add_development_dependency 'rails-dummy'
          s.add_development_dependency 'rails-i18n'
          s.add_development_dependency 'rspec-rails'
          s.add_development_dependency 'factory_bot_rails' # This has to be after rspec-rails
          s.add_development_dependency 'rubocop'
          s.add_development_dependency 'rubocop-rails_config'
          s.add_development_dependency 'shoulda-matchers'
          s.add_development_dependency 'simplecov'
          s.add_development_dependency 'simplecov-console'
          s.add_development_dependency 'bootsnap'
          s.add_development_dependency 'webpacker', '~> 4.0'
        end
      end
    end
  end
end
