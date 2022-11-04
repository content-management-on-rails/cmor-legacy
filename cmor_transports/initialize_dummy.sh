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
sed -i '17i\require "sprockets/rails"' config/application.rb
sed -i '17i\require "turbolinks"' config/application.rb
sed -i '17i\require "factory_bot_rails"' config/application.rb
sed -i '17i\require "cmor_cms"' config/application.rb
sed -i '17i\require "cmor_cms_backend"' config/application.rb

# Setup Simple Form
rails generate simple_form:install --bootstrap

# Setup ActiveStorage
rails active_storage:install

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
rails g cmor:core:backend:install

# Setup dummy app
rails g scaffold Post title body:text published_at:timestamp --no-test-framework
rails g factory_bot:model Post title body:text published_at:timestamp
rails g cmor:core:install
rails cmor_cms:install:migrations db:migrate db:test:prepare
rails g cmor:cms:install
rails g cmor:cms:backend:install
sed -i "2i  config.enable_feature(:cmor_transports, {})" config/initializers/cmor_core.rb

# Setup Cmor::Transports
rails generate cmor:transports:install
rails cmor_transports:install:migrations db:migrate db:test:prepare
