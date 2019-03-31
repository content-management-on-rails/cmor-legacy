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

## Always require rspec and factory_bot_rails in dummy app
sed -i '17i\require "rspec-rails"' config/application.rb
sed -i '17i\require "factory_bot_rails"' config/application.rb

# Add ActiveStorage
rails active_storage:install

# Configure I18n
touch config/initializers/i18n.rb
echo "Rails.application.config.i18n.available_locales = [:en, :de]" >> config/initializers/i18n.rb
echo "Rails.application.config.i18n.default_locale    = :de" >> config/initializers/i18n.rb

# Satisfy prerequisistes for cmor_system_backend
rails g model Post title body
sed -i '17i\require "delayed_job_active_record"' config/application.rb
rails generate delayed_job:active_record

# Install
CMOR_RBAC_USER_FACTORY_NAME='cmor_user_area_user' \
CMOR_RBAC_USER_CLASS_NAME='Cmor::UserArea::User' \
CMOR_BLOG_USER_FACTORY_NAME='cmor_user_area_user' \
CMOR_BLOG_CREATOR_CLASS_NAME='Cmor::UserArea::User' \
rails generate $INSTALL_NAME:install
rails db:migrate db:test:prepare

# Enable authentication
sed -i '2i\  before_action :authenticate_user!' app/controllers/backend_controller.rb
rails cmor:user_area:create_default_user
