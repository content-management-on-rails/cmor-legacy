#!/bin/bash
# Delete old dummy app
rm -rf spec/dummy

# Generate new dummy app
DISABLE_MIGRATE=true rake dummy:app
rm spec/dummy/.ruby-version

# Satisfy prerequisites
cd spec/dummy
rails g model User email
rails active_storage:install
touch config/initializers/i18n.rb
echo "Rails.application.config.i18n.available_locales = [:en, :de]" >> config/initializers/i18n.rb
echo "Rails.application.config.i18n.default_locale    = :de" >> config/initializers/i18n.rb

# Install
rails g cmor:blog:install
rails cmor_blog:install:migrations db:migrate db:test:prepare
