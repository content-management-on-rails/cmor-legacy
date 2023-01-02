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

# Setup simple form
rails generate simple_form:install --bootstrap

# Setup i18n
touch config/initializers/i18n.rb
echo "Rails.application.config.i18n.available_locales = [:en, :de]" >> config/initializers/i18n.rb
echo "Rails.application.config.i18n.default_locale    = :de" >> config/initializers/i18n.rb

# Setup i18n routing
touch config/initializers/route_translator.rb
echo "RouteTranslator.config do |config|" >> config/initializers/route_translator.rb
echo "  config.force_locale = true" >> config/initializers/route_translator.rb
echo "end" >> config/initializers/route_translator.rb

# Setup administrador
rails generate administrador:install

# Setup cmor_core
rails generate cmor:core:install

# Setup cmor_core_backend
rails generate cmor:core:backend:install

# Setup acts as taggabble
rails acts_as_taggable_on_engine:install:migrations

# Setup dummy app
rails generate model Post title
rails g factory_bot:model Post title
rails generate model Post title
sed -i '2i\  include Model::Cmor::Tags::TaggableConcern' app/models/post.rb
sed -i '2i\  alias_attribute :human, :title' app/models/post.rb

# Setup cmor-tags
rails cmor_tags:install:migrations
CMOR_TAGS_TAGGABLE_CLASS_NAMES='%w(Post)' rails generate cmor:tags:install

# Setup database
rails db:migrate db:test:prepare
