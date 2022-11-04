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
sed -i "17irequire 'sprockets/rails'" config/application.rb
sed -i "17irequire 'turbolinks'" config/application.rb
sed -i "17irequire 'cmor_cms'" config/application.rb

# Setup I18n
touch config/initializers/i18n.rb
echo "Rails.application.config.i18n.available_locales = [:en, :de]" >> config/initializers/i18n.rb
echo "Rails.application.config.i18n.default_locale    = :de" >> config/initializers/i18n.rb

# Setup I18n routing
touch config/initializers/route_translator.rb
echo "RouteTranslator.config do |config|" >> config/initializers/route_translator.rb
echo "  config.force_locale = true" >> config/initializers/route_translator.rb
echo "end" >> config/initializers/route_translator.rb

# Setup SimpleForm
rails generate simple_form:install --bootstrap

# Setup Administrador
rails generate administrador:install

# Setup Cmor::Core
rails generate cmor:core:install

# Setup Cmor::Core::Backend
rails generate cmor:core:backend:install

# Setup Cmor::Cms
rails generate cmor:cms:install
rails cmor_cms:install:migrations

# SEtup Cmor::Legal
rails generate cmor:legal:install

# Prepare spec database
rails db:migrate db:test:prepare
