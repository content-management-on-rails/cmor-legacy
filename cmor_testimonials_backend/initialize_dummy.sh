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
sed -i '17i\require "rspec-rails"' config/application.rb
sed -i '17i\require "factory_bot_rails"' config/application.rb
sed -i '17i\require "rails-i18n"' config/application.rb

# Setup Simple Form
rails generate simple_form:install --bootstrap

# Setup unpermitted params exceptions
echo "$(awk 'NR==46{print "'"  config.action_controller.action_on_unpermitted_parameters = :raise"'"}1' config/environments/development.rb)" > config/environments/development.rb
echo "$(awk 'NR==62{print "'"  config.action_controller.action_on_unpermitted_parameters = :raise"'"}1' config/environments/test.rb)" > config/environments/test.rb

# Setup I18n
touch config/initializers/i18n.rb
echo "Rails.application.config.i18n.available_locales = [:en, :de]" >> config/initializers/i18n.rb
echo "Rails.application.config.i18n.default_locale    = :de" >> config/initializers/i18n.rb

# Setup I18n routing
touch config/initializers/route_translator.rb
echo "RouteTranslator.config do |config|" >> config/initializers/route_translator.rb
echo "  config.force_locale = true" >> config/initializers/route_translator.rb
echo "end" >> config/initializers/route_translator.rb

# Setup ActiveStorage
rails active_storage:install:migrations

# Setup Administrador
rails generate administrador:install

# Setup Cmor::Core::Backend
rails generate cmor:core:backend:install

# Setup Cmor::Testimonials
rails generate cmor:testimonials:install
rails cmor_testimonials:install:migrations db:migrate db:test:prepare

# Setup Cmor::Testimonials::Backend
rails generate cmor:testimonials:backend:install