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
sed -i '17irequire "responders"' config/application.rb
sed -i '17irequire "rspec-rails"' config/application.rb
sed -i '17irequire "factory_bot_rails"' config/application.rb

# Setup I18n
touch config/initializers/i18n.rb
echo "Rails.application.config.i18n.available_locales = [:en, :de]" >> config/initializers/i18n.rb
echo "Rails.application.config.i18n.default_locale    = :de" >> config/initializers/i18n.rb

# Setup I18n routing
touch config/initializers/route_translator.rb
echo "RouteTranslator.config do |config|" >> config/initializers/route_translator.rb
echo "  config.force_locale = true" >> config/initializers/route_translator.rb
echo "end" >> config/initializers/route_translator.rb

# Setup Administrador
rails generate administrador:install

# Setup Cmor::Core::Backend
rails generate cmor:core:backend:install

# Setup dummy app
rails g model User email

# Setup Cmor::Rbac
rails generate cmor:rbac:install
rails cmor_rbac:install:migrations db:migrate db:test:prepare

# Setup Cmor::Rbac::Backend
rails generate cmor:rbac:backend:install
