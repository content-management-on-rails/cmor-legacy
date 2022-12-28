#!/bin/bash

# Delete old dummy app
rm -rf spec/dummy

# Generate new dummy app
DISABLE_MIGRATE=true bundle exec rake dummy:app

if [ ! -d "spec/dummy/config" ]; then exit 1; fi

# Cleanup
rm spec/dummy/.ruby-version
rm spec/dummy/Gemfile

cd spec/dummy

# Use correct Gemfile
sed -i "s|../Gemfile|../../../Gemfile|g" config/boot.rb

## Always require rspec and factory_bot_rails in dummy app
sed -i '17i\  require "rspec-rails"' config/application.rb
sed -i '17i\  require "factory_bot_rails"' config/application.rb

## I18n configuration
touch config/initializers/i18n.rb
echo "Rails.application.config.i18n.available_locales = [:en, :de]" >> config/initializers/i18n.rb
echo "Rails.application.config.i18n.default_locale    = :de" >> config/initializers/i18n.rb

# Add ActiveStorage
rails active_storage:install:migrations

# Setup cmor-core-api
rails generate cmor:core:api:install
rails cmor_core_api:install:migrations

# Setup cmor-galleries
rails generate cmor:galleries:install
rails cmor_galleries:install:migrations

# Setup cmor-galleries-api
BASE_CONTROLLER_CLASS_NAME=ApiController rails generate cmor:galleries:api:install

# Setup api authentication
touch app/controllers/api_controller.rb
echo "class ApiController < ActionController::API" >> app/controllers/api_controller.rb
echo "  include Cmor::Core::Api::Controllers::TokenAuthenticationConcern" >> app/controllers/api_controller.rb
echo "end" >> app/controllers/api_controller.rb

# Setup database
rails db:migrate db:test:prepare
