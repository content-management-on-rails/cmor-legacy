#!/bin/bash
GEM_NAME=${PWD##*/}
INSTALL_NAME=${GEM_NAME//cmor_/cmor\:}

# Delete old dummy app
rm -rf spec/dummy

# Generate new dummy app
DISABLE_MIGRATE=true rake dummy:app

if [ ! -d "spec/dummy/config" ]; then exit 1; fi

# Cleanup
rm spec/dummy/.ruby-version
rm spec/dummy/Gemfile

cd spec/dummy

# Use correct Gemfile
sed -i "s|../Gemfile|../../../Gemfile|g" config/boot.rb

# Use Webpacker
sed -i '17i\require "webpacker"' config/application.rb
rails webpacker:install

# Configure simpleform
rails generate simple_form:install --bootstrap

# I don't know why we need this all of a sudden
sed -i '17i\require "sassc-rails"' config/application.rb
sed -i '17i\require "turbolinks"' config/application.rb

## Always require rspec and factory_bot_rails in dummy app
sed -i '17i\require "rspec-rails"' config/application.rb
sed -i '17i\require "factory_bot_rails"' config/application.rb

# Configure I18n
touch config/initializers/i18n.rb
echo "Rails.application.config.i18n.available_locales = [:en, :de]" >> config/initializers/i18n.rb
echo "Rails.application.config.i18n.default_locale    = :de" >> config/initializers/i18n.rb

# Satisfy prerequisistes for cmor_system_backend
sed -i '17i\require "delayed_job_active_record"' config/application.rb
sed -i '17i\require "cmor/suite/all"' config/application.rb
rails generate delayed_job:active_record

# Add ActiveStorage
rails active_storage:install

# Example model for Cmor::System specs
rails g model Post title body
rails g factory_bot:model Post title body # @TODO find out why we need this here bot not in other cmor gems.

# Install
CMOR_RBAC_USER_FACTORY_NAME='cmor_user_area_user' \
CMOR_RBAC_USER_CLASS_NAME='Cmor::UserArea::User' \
CMOR_BLOG_USER_FACTORY_NAME='cmor_user_area_user' \
CMOR_BLOG_CREATOR_CLASS_NAME='Cmor::UserArea::User' \
CMOR_SYSTEM_ENABLE_ACTIVE_STORAGE=true \
CMOR_SYSTEM_ENABLE_DELAYED_JOB=true \
CMOR_SYSTEM_RECORD_FACTORY_NAME='cmor_blog_post' \
CMOR_SYSTEM_RECORD_ATTACHMENT_NAME='assets' \
CMOR_TAGS_BACKEND_TAGGABLE_CLASSES='%w( Cmor::Blog::Post )' \
CMOR_TAGS_BACKEND_TAGGER_CLASSES='%w( Cmor::UserArea::User )' \
CMOR_TAGS_TAGGABLE_FACTORY_NAME=':cmor_blog_post' \
CMOR_TAGS_TAGGABLE_CLASS_NAMES='%w( Cmor::Blog::Post )' \
rails generate $INSTALL_NAME:install
rails db:migrate db:test:prepare

# Enable authentication
sed -i '2i\  before_action :authenticate_user!' app/controllers/backend_controller.rb
rails cmor:user_area:create_user
