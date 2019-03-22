#!/bin/bash
GEM_NAME=${PWD##*/}
INSTALL_NAME=${GEM_NAME//cmor_/cmor\:}

# Delete old dummy app
rm -rf spec/dummy

# Generate new dummy app
DISABLE_MIGRATE=true rake dummy:app
rm spec/dummy/.ruby-version

# Satisfy prerequisites
cd spec/dummy
touch config/initializers/i18n.rb
echo "Rails.application.config.i18n.available_locales = [:en, :de]" >> config/initializers/i18n.rb
echo "Rails.application.config.i18n.default_locale    = :de" >> config/initializers/i18n.rb
rails acts_as_taggable_on_engine:install:migrations
rails generate model Post email
sed -i '2i   include Model::Cmor::Tags::TaggableConcern' app/models/post.rb

# Install
rails generate $INSTALL_NAME:install
rails db:migrate db:test:prepare
