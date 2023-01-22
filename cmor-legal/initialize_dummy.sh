#!/bin/bash

# delete old dummy app
rm -rf spec/dummy

# generate new dummy app
DISABLE_MIGRATE=true bundle exec rake dummy:app

if [ ! -d "spec/dummy/config" ]; then exit 1; fi

# cleanup
rm spec/dummy/.ruby-version
rm spec/dummy/Gemfile

cd spec/dummy

# use correct Gemfile
sed -i "s|../Gemfile|../../../Gemfile|g" config/boot.rb

# Ssetup i18n
touch config/initializers/i18n.rb
echo "Rails.application.config.i18n.available_locales = [:en, :de]" >> config/initializers/i18n.rb
echo "Rails.application.config.i18n.default_locale    = :de" >> config/initializers/i18n.rb

# setup i18n routing
touch config/initializers/route_translator.rb
echo "RouteTranslator.config do |config|" >> config/initializers/route_translator.rb
echo "  config.force_locale = true" >> config/initializers/route_translator.rb
echo "end" >> config/initializers/route_translator.rb

# setup turbolinks
sed -i "15irequire 'turbolinks'" config/application.rb

# setup simple form
rails generate simple_form:install --bootstrap

# setup administrador
rails generate administrador:install

# setup cmor-core
rails generate cmor:core:install
rails generate cmor:core:backend:install

# setup cmor-cms
rails generate cmor:cms:install
rails cmor_cms:install:migrations
# sed -i "15irequire 'cmor_cms'" config/application.rb

# setup cmor-legal
rails generate cmor:legal:install

# prepare spec database
rails db:migrate db:test:prepare
