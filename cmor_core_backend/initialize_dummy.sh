#!/bin/bash
BACKEND_GEM_NAME=${PWD##*/}
BACKEND_INSTALL_NAME=${BACKEND_GEM_NAME//cmor_/cmor\:}
BACKEND_INSTALL_NAME=${BACKEND_INSTALL_NAME//_backend/\:backend}
GEM_NAME=${BACKEND_GEM_NAME//_backend/}
INSTALL_NAME=${BACKEND_INSTALL_NAME//\:backend/}

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

# responders for rao-service_controller
# sed -i '17i\  require "responders"' config/application.rb

## Always require rspec and factory_bot_rails in dummy app
sed -i '17i\  require "rspec-rails"' config/application.rb
sed -i '17i\  require "factory_bot_rails"' config/application.rb

## I18n configuration
touch config/initializers/i18n.rb
echo "Rails.application.config.i18n.available_locales = [:en, :de]" >> config/initializers/i18n.rb
echo "Rails.application.config.i18n.default_locale    = :de" >> config/initializers/i18n.rb

## I18n routing
# touch config/initializers/route_translator.rb
# echo "RouteTranslator.config do |config|" >> config/initializers/route_translator.rb
# echo "  config.force_locale = true" >> config/initializers/route_translator.rb
# echo "end" >> config/initializers/route_translator.rb

# Install administrador
rails generate administrador:install

# Install SimpleForm
rails generate simple_form:install --bootstrap

# Add DelayedJob::ActiveRecord
# sed -i '17i\  require "delayed_job_active_record"' config/application.rb
# rails generate delayed_job:active_record

# Add ActiveStorage
# rails active_storage:install

# Example model for ActiveStorage specs
# rails g model Post title

# rails db:migrate db:test:prepare

# Install
rails generate $BACKEND_INSTALL_NAME:install