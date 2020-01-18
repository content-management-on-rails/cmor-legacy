#!/bin/bash
GEM_NAME=${PWD##*/}
INSTALL_NAME=${GEM_NAME//cmor_/cmor\:}
INSTALL_NAME=${INSTALL_NAME//_frontend/\:frontend}
MIGRATION_NAME=${GEM_NAME//_frontend/}

# Delete old dummy app
rm -rf spec/dummy

# Generate new dummy app
DISABLE_MIGRATE=true rake dummy:app

rm spec/dummy/.ruby-version
rm spec/dummy/Gemfile

# Satisfy prerequisites
cd spec/dummy

# Use correct Gemfile
sed -i "s|../Gemfile|../../../Gemfile|g" config/boot.rb

# Add ActiveStorage
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

# Add turbolinks
sed -i "15irequire 'turbolinks'" config/application.rb
sed -i "16irequire 'factory_bot_rails'" config/application.rb

# Add needed models
rails g model Post title

# Install
rails generate cmor:seo:install
rails generate $INSTALL_NAME:install
rails $MIGRATION_NAME:install:migrations db:migrate db:test:prepare
