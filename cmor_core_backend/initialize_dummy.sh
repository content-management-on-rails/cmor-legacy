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
sed -i "16irequire 'sprockets/rails'" config/application.rb
sed -i '16irequire "rspec-rails"' config/application.rb
sed -i '16irequire "factory_bot_rails"' config/application.rb

# Setup SimpleForm
rails generate simple_form:install --bootstrap

# Setup I18n
touch config/initializers/i18n.rb
echo "Rails.application.config.i18n.available_locales = [:en, :de]" >> config/initializers/i18n.rb
echo "Rails.application.config.i18n.default_locale    = :de" >> config/initializers/i18n.rb

## Setup I18n routing
# touch config/initializers/route_translator.rb
# echo "RouteTranslator.config do |config|" >> config/initializers/route_translator.rb
# echo "  config.force_locale = true" >> config/initializers/route_translator.rb
# echo "end" >> config/initializers/route_translator.rb

# Setup administrador
rails generate administrador:install

# Setup DelayedJob::ActiveRecord
# sed -i '17i\  require "delayed_job_active_record"' config/application.rb
# rails generate delayed_job:active_record

# Setup ActiveStorage
# rails active_storage:install

# Setup example model for ActiveStorage specs
# rails g model Post title

# rails db:migrate db:test:prepare

# Install
rails generate cmor:core:backend:install
