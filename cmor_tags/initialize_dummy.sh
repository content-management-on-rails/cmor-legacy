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
sed -i '17i\require "webpacker"' config/application.rb
sed -i '17i\require "responders"' config/application.rb
sed -i '17i\require "rspec-rails"' config/application.rb
sed -i '17i\require "factory_bot_rails"' config/application.rb

# Setup Webpacker
rails webpacker:install

# Setup SimpleForm
rails generate simple_form:install --bootstrap

# Setup I18n
touch config/initializers/i18n.rb
echo "Rails.application.config.i18n.available_locales = [:en, :de]" >> config/initializers/i18n.rb
echo "Rails.application.config.i18n.default_locale    = :de" >> config/initializers/i18n.rb

# Setup I18n routing
touch config/initializers/route_translator.rb
echo "RouteTranslator.config do |config|" >> config/initializers/route_translator.rb
echo "  config.force_locale = true" >> config/initializers/route_translator.rb
echo "end" >> config/initializers/route_translator.rb

# Setup acts as taggabble
rails acts_as_taggable_on_engine:install:migrations

# Setup dummy app
rails generate model Post title
rails g factory_bot:model Post title
sed -i '2i\  include Model::Cmor::Tags::TaggableConcern' app/models/post.rb
mkdir -p app/views/posts
touch app/views/posts/_post.html.haml
echo "= post.title" >> app/views/posts/_post.html.haml

# Setup Cmor::Tags
rails generate cmor:tags:install
rails db:migrate db:test:prepare
