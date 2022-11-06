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

# Needed requires
sed -i '17i\require "sprockets/rails"' config/application.rb
sed -i "17i\require 'turbolinks'" config/application.rb
sed -i "17i\require 'factory_bot_rails'" config/application.rb

# Setup SimpleForm
rails generate simple_form:install --bootstrap

# Setup ActiveStorage
# rails active_storage:install

# Setup I18n
touch config/initializers/i18n.rb
echo "Rails.application.config.i18n.available_locales = [:en, :de]" >> config/initializers/i18n.rb
echo "Rails.application.config.i18n.default_locale    = :de" >> config/initializers/i18n.rb

# Setup I18n routing
touch config/initializers/route_translator.rb
echo "RouteTranslator.config do |config|" >> config/initializers/route_translator.rb
echo "  config.force_locale = true" >> config/initializers/route_translator.rb
echo "end" >> config/initializers/route_translator.rb

# Setup Administrador
rails generate administrador:install

# Setup Cmor::Core::Backend
rails g cmor:core:backend:install

# Setup Cmor::Core::Api
rails g cmor:core:api:install
rails cmor_core_api:install:migrations db:migrate db:test:prepare

# Setup Cmor::Core::Api::Backend
rails generate cmor:core:api:backend:install
