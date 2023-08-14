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

# Setup rao-service_controller
sed -i '17irequire "responders"' config/application.rb

# Setup rspec-rails
sed -i '17irequire "rspec-rails"' config/application.rb

# Setup factory_bot_rails
sed -i '17irequire "factory_bot_rails"' config/application.rb

# Setup i18n
touch config/initializers/i18n.rb
echo "Rails.application.config.i18n.available_locales = [:en, :de]" >> config/initializers/i18n.rb
echo "Rails.application.config.i18n.default_locale    = :de" >> config/initializers/i18n.rb

# Setup i18n routing
touch config/initializers/route_translator.rb
echo "RouteTranslator.config do |config|" >> config/initializers/route_translator.rb
echo "  config.force_locale = true" >> config/initializers/route_translator.rb
echo "  config.i18n_use_slash_separator = true" >> config/initializers/route_translator.rb
echo "end" >> config/initializers/route_translator.rb

# Setup cmor_core_backend
rails generate administrador:install
rails generate cmor:core:backend:install

# Setup SimpleForm
rails generate simple_form:install --bootstrap

# Setup delayed_job-active_record
sed -i '17irequire "delayed_job_active_record"' config/application.rb
rails generate delayed_job:active_record

# Setup ActiveStorage
rails active_storage:install

# Setup example model for ActiveStorage specs
rails g model Post title
sed -i '2i\  has_one_attached Cmor::System::Configuration.record_attachment_name' app/models/post.rb

rails db:migrate db:test:prepare

# Setup cmor-system
CMOR_SYSTEM_ENABLE_ACTIVE_STORAGE=true CMOR_SYSTEM_ENABLE_DELAYED_JOB=true rails generate cmor:system:install
