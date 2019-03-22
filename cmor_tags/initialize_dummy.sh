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

## I18n configuration
touch config/initializers/i18n.rb
echo "Rails.application.config.i18n.available_locales = [:en, :de]" >> config/initializers/i18n.rb
echo "Rails.application.config.i18n.default_locale    = :de" >> config/initializers/i18n.rb

## acts as taggabble
rails acts_as_taggable_on_engine:install:migrations

# Example model
rails generate model Post title
sed -i '2i\  include Model::Cmor::Tags::TaggableConcern' app/models/post.rb
mkdir -p app/views/posts
touch app/views/posts/_post.html.haml
echo "= post.title" >> app/views/posts/_post.html.haml

# I18n routing
touch config/initializers/route_translator.rb
echo "RouteTranslator.config do |config|" >> config/initializers/route_translator.rb
echo "  config.force_locale = true" >> config/initializers/route_translator.rb
echo "end" >> config/initializers/route_translator.rb

# responders for rao-service_controller
sed -i '17i\  require "responders"' config/application.rb

# Install
rails generate $INSTALL_NAME:install
rails db:migrate db:test:prepare
