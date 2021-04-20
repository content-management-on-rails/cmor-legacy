#!/bin/bash
GEM_NAME=${PWD##*/}
PREFIX="cmor"
NAME=${GEM_NAME//${PREFIX}_/}
COLONIZED_NAME=${NAME//_/\:}
BASENAME=${NAME//_frontend/}
COLONIZED_BASENAME=${BASENAME//_/\:}
INSTALLER_NAME="${PREFIX}:${COLONIZED_NAME}:install"
BACKEND_INSTALLER_NAME="${PREFIX}:${COLONIZED_BASENAME}:install"
BACKEND_MIGRATION_NAME="${PREFIX}_${BASENAME}:install:migrations"

# Delete old dummy app
rm -rf spec/dummy

# Generate new dummy app
DISABLE_MIGRATE=true rake dummy:app

if [ ! -d "spec/dummy/config" ]; then exit 1; fi

# Cleanup
rm spec/dummy/.ruby-version
rm spec/dummy/Gemfile

cd spec/dummy

# Use correct Gemfile
sed -i "s|../Gemfile|../../../Gemfile|g" config/boot.rb

# Install simple form
rails generate simple_form:install --bootstrap

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

# Install administrador
rails generate administrador:install

# Install SimpleForm
rails generate simple_form:install --bootstrap

# Install cmor_core_backend
rails g cmor:core:backend:install

# Install markup-rails
rails g markup:rails:install

# Install backend
rails generate $BACKEND_INSTALLER_NAME
rails $BACKEND_MIGRATION_NAME db:migrate db:test:prepare
# Install
rails generate $INSTALLER_NAME
