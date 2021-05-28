#!/bin/bash

DUMMY_APP_PATH="spec/dummy"

# Delete old dummy app
if [ -d "$DUMMY_APP_PATH" ]; then rm -rf $DUMMY_APP_PATH; fi


# Generate new dummy app
DUMMY_APP_PATH=$DUMMY_APP_PATH DISABLE_MIGRATE=true bundle exec rake dummy:app

if [ ! -d "$DUMMY_APP_PATH/config" ]; then exit 1; fi

rm $DUMMY_APP_PATH/.ruby-version
rm $DUMMY_APP_PATH/Gemfile

cd $DUMMY_APP_PATH

# Use correct Gemfile
sed -i "s|../Gemfile|../../../Gemfile|g" config/boot.rb

# I18n configuration
touch config/initializers/i18n.rb
echo "Rails.application.config.i18n.available_locales = [:en, :de]" >> config/initializers/i18n.rb
echo "Rails.application.config.i18n.default_locale    = :de" >> config/initializers/i18n.rb

# I18n routing
touch config/initializers/route_translator.rb
echo "RouteTranslator.config do |config|" >> config/initializers/route_translator.rb
echo "  config.force_locale = true" >> config/initializers/route_translator.rb
echo "end" >> config/initializers/route_translator.rb

# Turbolinks
sed -i "15irequire 'turbolinks'" config/application.rb

# Satisfy prerequisites
sed -i "15irequire 'cmor_cms'" config/application.rb
rails generate simple_form:install --bootstrap
rails generate administrador:install
rails generate cmor:core:install
rails generate cmor:core:backend:install
rails generate cmor:cms:install
rails cmor_cms:install:migrations

# Install gem
rails generate cmor:legal:install

# prepare spec database
rails db:migrate db:test:prepare