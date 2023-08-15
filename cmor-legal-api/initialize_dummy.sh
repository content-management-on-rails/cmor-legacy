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

# Use Webpacker
sed -i '17i\require "webpacker"' config/application.rb
rails webpacker:install

## Always require rspec and factory_bot_rails in dummy app
sed -i '17i\  require "rspec-rails"' config/application.rb
sed -i '17i\  require "factory_bot_rails"' config/application.rb

## I18n configuration
touch config/initializers/i18n.rb
echo "Rails.application.config.i18n.available_locales = [:en, :de]" >> config/initializers/i18n.rb
echo "Rails.application.config.i18n.default_locale    = :de" >> config/initializers/i18n.rb

# Add ActiveStorage
rails active_storage:install:migrations

# Setup ActiveRecord encryption
ARE_CONF=$(cat <<-END
active_record_encryption:
  primary_key: L65Ufyp4rGhy6Ljey0FURgzTxMfz5bmf
  deterministic_key: Wgxp51Q5mVF8zPjeCMx34Ve5FI5cA9WA
  key_derivation_salt: V0uzZUabwzurOw8HZmJbPC6XAFMGmedv
END
)

EDITOR="echo \"$ARE_CONF\" >> " rails credentials:edit

# Setup cmor-core-api
rails generate cmor:core:api:install
rails cmor_core_api:install:migrations

# Setup cmor-legal
rails generate cmor:legal:install
rails cmor:legal:install:migrations

# Setup cmor-legal-api
BASE_CONTROLLER_CLASS_NAME=ApiController rails generate cmor:legal:api:install

# Setup api authentication
touch app/controllers/api_controller.rb
echo "class ApiController < ActionController::API" >> app/controllers/api_controller.rb
echo "  include Cmor::Core::Api::Controllers::TokenAuthenticationConcern" >> app/controllers/api_controller.rb
echo "  before_action :authenticate_with_token!" >> app/controllers/api_controller.rb
echo "end" >> app/controllers/api_controller.rb

# Setup cmor_cms
rails generate cmor:cms:install
rails cmor_cms:install:migrations
sed -i "15irequire 'cmor_cms'" config/application.rb

# Setup database
rails db:migrate db:test:prepare

# Setup unpermitted params
sed -i '9i\  config.action_controller.action_on_unpermitted_parameters = :raise' config/environments/test.rb
