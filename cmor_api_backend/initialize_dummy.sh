#!/bin/bash
GEM_NAME=${PWD##*/}
INSTALL_NAME=${GEM_NAME//cmor_/cmor\:}
INSTALL_NAME=${INSTALL_NAME//_backend/\:backend}
MIGRATION_NAME=${GEM_NAME//_backend/}

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
# touch config/initializers/route_translator.rb
# echo "RouteTranslator.config do |config|" >> config/initializers/route_translator.rb
# echo "  config.force_locale = true" >> config/initializers/route_translator.rb
# echo "end" >> config/initializers/route_translator.rb

# Add turbolinks
# sed -i "15irequire 'turbolinks'" config/application.rb

# Add needed models
# rails g model Post title

# install dependencies
CMOR_BLOG_USER_FACTORY_NAME="cmor_user_area_user" CMOR_BLOG_CREATOR_CLASS_NAME="Cmor::UserArea::User" rails generate cmor:blog:install

rails generate cmor:blog:backend:install
rails generate cmor:cms:backend:install
rails generate cmor:user_area:backend:install

rails cmor_blog:install:migrations
rails cmor_cms:install:migrations
rails cmor_user_area:install:migrations

# Install
rails generate $INSTALL_NAME:install
# rails $MIGRATION_NAME:install:migrations db:migrate db:test:prepare
rails db:migrate db:test:prepare
