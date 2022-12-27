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

## Always require rspec and factory_bot_rails in dummy app
sed -i '17i\  require "rspec-rails"' config/application.rb
sed -i '17i\  require "factory_bot_rails"' config/application.rb

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

# Add User model for userstamping
rails g model User email
sed -i '2i\  private' app/controllers/application_controller.rb
sed -i '3i\  ' app/controllers/application_controller.rb
sed -i '4i\  def current_user' app/controllers/application_controller.rb
sed -i '5i\    User.first_or_create!(email: "jane.doe@domain.local")' app/controllers/application_controller.rb
sed -i '6i\  end' app/controllers/application_controller.rb

# Install cmor core backend gem
rails generate administrador:install
rails generate cmor:core:backend:install

# CMOR Blog
rails generate cmor:blog:install
rails cmor_blog:install:migrations db:migrate db:test:prepare

