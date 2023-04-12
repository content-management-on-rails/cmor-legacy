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

# setup simple form
rails generate simple_form:install --bootstrap

# setup webpacker
rails webpacker:install

# setup active storage
# rails active_storage:install

# setup i18n
touch config/initializers/i18n.rb
echo "Rails.application.config.i18n.available_locales = [:en, :de]" >> config/initializers/i18n.rb
echo "Rails.application.config.i18n.default_locale    = :de" >> config/initializers/i18n.rb

# setup i18n routing
touch config/initializers/route_translator.rb
echo "RouteTranslator.config do |config|" >> config/initializers/route_translator.rb
echo "  config.force_locale = true" >> config/initializers/route_translator.rb
echo "end" >> config/initializers/route_translator.rb

# setup turbolinks
sed -i "15irequire 'turbolinks'" config/application.rb

# setup assets
sed -i "16irequire 'sprockets/rails'" config/application.rb

# setup factory bot
sed -i "17irequire 'factory_bot_rails'" config/application.rb

# setup administrador
rails generate administrador:install

# setup  cmor_core_backend
rails g cmor:core:backend:install

# setup cmor-core-api
rails g cmor:core:api:install
rails cmor_core_api:install:migrations db:migrate db:test:prepare

# setup cmor-core-api-backend
rails generate cmor:core:api:backend:install
