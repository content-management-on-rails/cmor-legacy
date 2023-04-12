#!/bin/bash

# Delete old dummy app
rm -rf spec/dummy

# Generate new dummy app
DISABLE_MIGRATE=true bundle exec rake dummy:app

if [ ! -d "spec/dummy/config" ]; then exit 1; fi

# cleanup
rm spec/dummy/.ruby-version
rm spec/dummy/Gemfile

cd spec/dummy

# use correct Gemfile
sed -i "s|../Gemfile|../../../Gemfile|g" config/boot.rb

# setup responders for rao-service_controller
sed -i '17i\  require "responders"' config/application.rb

# setup testing
sed -i '17i\  require "rspec-rails"' config/application.rb
sed -i '17i\  require "factory_bot_rails"' config/application.rb

# setup i18n
touch config/initializers/i18n.rb
echo "Rails.application.config.i18n.available_locales = [:en, :de]" >> config/initializers/i18n.rb
echo "Rails.application.config.i18n.default_locale    = :de" >> config/initializers/i18n.rb

# setup i18n routing
touch config/initializers/route_translator.rb
echo "RouteTranslator.config do |config|" >> config/initializers/route_translator.rb
echo "  config.force_locale = true" >> config/initializers/route_translator.rb
echo "end" >> config/initializers/route_translator.rb

# setup administrador
rails generate administrador:install

# setup cmor_core_backend
rails generate cmor:core:backend:install

# setup cmor_cms
rails cmor_cms:install:migrations db:migrate db:test:prepare
rails generate cmor:cms:install

# setup cmor_cms_backend
rails generate cmor:cms:backend:install
sed -i "39i  config.active_record.yaml_column_permitted_classes = [OpenStruct, Symbol]" config/application.rb

