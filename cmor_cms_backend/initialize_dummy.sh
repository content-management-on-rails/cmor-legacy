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
sed -i "17i\  require 'sprockets/rails'" config/application.rb
sed -i '17i\  require "responders"' config/application.rb
sed -i '17i\  require "rspec-rails"' config/application.rb
sed -i '17i\  require "factory_bot_rails"' config/application.rb

# Install SimpleForm
rails generate simple_form:install --bootstrap

## I18n configuration
touch config/initializers/i18n.rb
echo "Rails.application.config.i18n.available_locales = [:en, :de]" >> config/initializers/i18n.rb
echo "Rails.application.config.i18n.default_locale    = :de" >> config/initializers/i18n.rb

# Fix psych
sed -i '39i\    config.active_record.yaml_column_permitted_classes = [OpenStruct]' config/application.rb

## I18n routing
touch config/initializers/route_translator.rb
echo "RouteTranslator.config do |config|" >> config/initializers/route_translator.rb
echo "  config.force_locale = true" >> config/initializers/route_translator.rb
echo "end" >> config/initializers/route_translator.rb

# Install cmor core backend gem
rails generate administrador:install
rails generate cmor:core:backend:install

# CMOR CMS
rails cmor_cms:install:migrations db:migrate db:test:prepare
rails generate cmor:cms:install

# Install
rails generate cmor:cms:backend:install
