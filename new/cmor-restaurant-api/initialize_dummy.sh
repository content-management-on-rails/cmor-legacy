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

# Setup webpacker
rails webpacker:install

# Setup simple form
rails generate simple_form:install --bootstrap

# Setup active storage
rails active_storage:install

# Setup i18n
touch config/initializers/i18n.rb
echo "Rails.application.config.i18n.available_locales = [:en, :de]" >> config/initializers/i18n.rb
echo "Rails.application.config.i18n.default_locale    = :de" >> config/initializers/i18n.rb

# Setup i18n routing
touch config/initializers/route_translator.rb
echo "RouteTranslator.config do |config|" >> config/initializers/route_translator.rb
echo "  config.force_locale = true" >> config/initializers/route_translator.rb
echo "end" >> config/initializers/route_translator.rb

# Setup cors
echo "require 'rack/cors'" >> config/initializers/cors.rb
echo "Rails.application.config.middleware.insert_before 0, Rack::Cors do" >> config/initializers/cors.rb
echo "  allow do" >> config/initializers/cors.rb
echo "    origins '*'" >> config/initializers/cors.rb
echo "    resource '*'," >> config/initializers/cors.rb
echo "      headers: :any," >> config/initializers/cors.rb
echo "      methods: [:get, :post, :put, :patch, :delete, :options, :head], expose: ['Content-Disposition']" >> config/initializers/cors.rb
echo "  end" >> config/initializers/cors.rb
echo "end" >> config/initializers/cors.rb

# Setup administrador
rails generate administrador:install

# Setup cmor_core
rails generate cmor:core:install

# Setup cmor_core_backend
rails generate cmor:core:backend:install

# Setup cmor-restaurant
rails cmor_restaurant:install:migrations
rails generate cmor:restaurant:install

# Setup database
rails db:migrate db:test:prepare

# Setup cmor-restaurant-api
rails generate cmor:restaurant:api:install
