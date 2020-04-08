#!/bin/bash
GEM_NAME=cmor_multi_tenancy
INSTALL_NAME=${GEM_NAME//cmor_/cmor\:}

# Delete old dummy app
rm -rf spec/dummy

# Generate new dummy app
DISABLE_MIGRATE=true rake dummy:app

if [ ! -d "spec/dummy" ]; then
  echo "Dummy app was not generated. Exiting..."
  exit 1
fi

# Satisfy prerequisites
cd spec/dummy

rm .ruby-version

# Use correct Gemfile
rm Gemfile
sed -i "s|../Gemfile|../../../Gemfile|g" config/boot.rb

# Add ActiveStorage
rails active_storage:install

# I18n configuration
touch config/initializers/i18n.rb
echo "Rails.application.config.i18n.available_locales = [:en, :de]" >> config/initializers/i18n.rb
echo "Rails.application.config.i18n.default_locale    = :de" >> config/initializers/i18n.rb

# I18n routing
touch config/initializers/route_translator.rb
echo "RouteTranslator.config do |config|" >> config/initializers/route_translator.rb
echo "  config.force_locale = true" >> config/initializers/route_translator.rb
echo "end" >> config/initializers/route_translator.rb

# Add turbolinks
sed -i "15irequire 'turbolinks'" config/application.rb

# Install administrador
rails generate administrador:install

# Install SimpleForm
rails generate simple_form:install --bootstrap

# Install cmor_core_backend
rails g cmor:core:backend:install

# Install
rails generate $INSTALL_NAME:install
rails $GEM_NAME:install:migrations db:migrate db:test:prepare
