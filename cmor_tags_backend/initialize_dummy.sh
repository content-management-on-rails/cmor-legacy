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

# responders for rao-service_controller
sed -i '17i\  require "responders"' config/application.rb

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

## Acts as taggabble
rails acts_as_taggable_on_engine:install:migrations

# Example post model for specs
rails generate model Post title
sed -i '2i\  include Model::Cmor::Tags::TaggableConcern' app/models/post.rb
sed -i '2i\  alias_attribute :human, :title' app/models/post.rb

# Install cmor core backend gem
rails generate administrador:install
rails generate cmor:core:backend:install

# Install frontend gem
rails generate cmor:tags:install
rails cmor_tags:install:migrations db:migrate db:test:prepare

# Install
CMOR_TAGS_BACKEND_TAGGABLE_CLASSES='%w(Post)' rails generate cmor:tags:backend:install