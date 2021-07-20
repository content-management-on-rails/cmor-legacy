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

# SimpleForm
rails generate simple_form:install --bootstrap

# ActiveStorage
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

# Turbolinks
sed -i "15irequire 'turbolinks'" config/application.rb

# Factory bot
sed -i "16irequire 'factory_bot_rails'" config/application.rb

# Administrador
rails generate administrador:install

# Install cmor_core_backend
rails g cmor:core:backend:install

# Setup specs
rails g model Post
sed -i "2i\  has_many_attached :assets" app/models/post.rb

# Install
rails generate cmor:security:install
# rails cmor_security:install:migrations db:migrate db:test:prepare
