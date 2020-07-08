#!/bin/bash
GEM_NAME=${PWD##*/}
INSTALL_NAME=${GEM_NAME//cmor_/cmor\:}

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
# sed -i "16irequire 'factory_bot_rails'" config/application.rb

# Install administrador
rails generate administrador:install

# Install SimpleForm
rails generate simple_form:install --bootstrap

# Install cmor_core_backend
rails g cmor:core:backend:install

# Install paper trail
rails g paper_trail:install

# Setup specs
rails g model Post title body:text

# Install
rails generate $INSTALL_NAME:install
# rails $GEM_NAME:install:migrations
rails db:migrate db:test:prepare
