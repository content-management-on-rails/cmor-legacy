#!/bin/bash
BACKEND_GEM_NAME=${PWD##*/}
BACKEND_INSTALL_NAME=${BACKEND_GEM_NAME//cmor_/cmor\:}
# BACKEND_INSTALL_NAME=${BACKEND_INSTALL_NAME//_backend/\:backend}
GEM_NAME=${BACKEND_GEM_NAME//_backend/}
INSTALL_NAME=${BACKEND_INSTALL_NAME//\:backend/}

# Delete old dummy app
rm -rf spec/dummy

# Generate new dummy app
DISABLE_MIGRATE=true rake dummy:app
rm spec/dummy/.ruby-version

# Satisfy prerequisites
cd spec/dummy

# responders for rao-service_controller
sed -i '17irequire "responders"' config/application.rb

## Always require rspec and factory_bot_rails in dummy app
sed -i '17irequire "rspec-rails"' config/application.rb
sed -i '17irequire "factory_bot_rails"' config/application.rb

## I18n configuration
touch config/initializers/i18n.rb
echo "Rails.application.config.i18n.available_locales = [:en, :de]" >> config/initializers/i18n.rb
echo "Rails.application.config.i18n.default_locale    = :de" >> config/initializers/i18n.rb

## I18n routing
touch config/initializers/route_translator.rb
echo "RouteTranslator.config do |config|" >> config/initializers/route_translator.rb
echo "  config.force_locale = true" >> config/initializers/route_translator.rb
echo "end" >> config/initializers/route_translator.rb

# Install cmor core backend gem
rails generate administrador:install
rails generate cmor:core:backend:install

# Install SimpleForm
rails generate simple_form:install --bootstrap

# Add DelayedJob::ActiveRecord
sed -i '17irequire "delayed_job_active_record"' config/application.rb
rails generate delayed_job:active_record

# Add ActiveStorage
rails active_storage:install

# Example model for ActiveStorage specs
rails g model Post title

rails db:migrate db:test:prepare

# Install
CMOR_SYSTEM_ENABLE_ACTIVE_STORAGE=true CMOR_SYSTEM_ENABLE_DELAYED_JOB=true rails generate $BACKEND_INSTALL_NAME:install