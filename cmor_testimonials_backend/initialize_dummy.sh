#!/bin/bash
BACKEND_GEM_NAME=${PWD##*/}
BACKEND_INSTALL_NAME=${BACKEND_GEM_NAME//cmor_/cmor\:}
BACKEND_INSTALL_NAME=${BACKEND_INSTALL_NAME//_backend/\:backend}
GEM_NAME=${BACKEND_GEM_NAME//_backend/}
INSTALL_NAME=${BACKEND_INSTALL_NAME//\:backend/}

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

# Install simple form
rails generate simple_form:install --bootstrap

## Always require rspec and factory_bot_rails in dummy app
required_gems="require 'rspec-rails'\nrequire 'factory_bot_rails'\nrequire 'rails-i18n'\n"
echo "$(awk 'NR==17{print "'"$required_gems"'"}1' config/application.rb)" > config/application.rb

## raise on unpermitted params
echo "$(awk 'NR==46{print "'"  config.action_controller.action_on_unpermitted_parameters = :raise"'"}1' config/environments/development.rb)" > config/environments/development.rb
echo "$(awk 'NR==62{print "'"  config.action_controller.action_on_unpermitted_parameters = :raise"'"}1' config/environments/test.rb)" > config/environments/test.rb

## I18n configuration
touch config/initializers/i18n.rb
echo "Rails.application.config.i18n.available_locales = [:en, :de]" >> config/initializers/i18n.rb
echo "Rails.application.config.i18n.default_locale    = :de" >> config/initializers/i18n.rb

## I18n routing
touch config/initializers/route_translator.rb
echo "RouteTranslator.config do |config|" >> config/initializers/route_translator.rb
echo "  config.force_locale = true" >> config/initializers/route_translator.rb
echo "end" >> config/initializers/route_translator.rb

# Add ActiveStorage
rails active_storage:install:migrations

# Install cmor core backend gem
rails generate administrador:install
rails generate cmor:core:backend:install

# Install frontend gem
rails generate $INSTALL_NAME:install
rails $GEM_NAME:install:migrations db:migrate db:test:prepare

# Install
rails generate $BACKEND_INSTALL_NAME:install