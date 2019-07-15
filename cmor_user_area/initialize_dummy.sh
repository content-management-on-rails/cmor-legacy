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

# Install SimpleForm
rails generate simple_form:install --bootstrap

# Add ActiveStorage
rails active_storage:install
touch config/initializers/i18n.rb
echo "Rails.application.config.i18n.available_locales = [:en, :de]" >> config/initializers/i18n.rb
echo "Rails.application.config.i18n.default_locale    = :de" >> config/initializers/i18n.rb

# I18n routing
touch config/initializers/route_translator.rb
echo "RouteTranslator.config do |config|" >> config/initializers/route_translator.rb
echo "  config.force_locale = true" >> config/initializers/route_translator.rb
echo "end" >> config/initializers/route_translator.rb

# Frontend setup
sed -i '2i\  view_helper Cmor::Core::ApplicationViewHelper, as: :core_helper' app/controllers/application_controller.rb
sed -i '3i\  view_helper Cmor::UserArea::ApplicationViewHelper, as: :user_area_helper' app/controllers/application_controller.rb

sed -i '13i\    <%= user_area_helper(self).render_navigation %>' app/views/layouts/application.html.erb
sed -i '14i\    <%= core_helper(self).render_flash %>' app/views/layouts/application.html.erb

sed -i '3i\  localized { root to: "home#index" }' config/routes.rb

touch app/controllers/home_controller.rb
echo "class HomeController < ApplicationController" >> app/controllers/home_controller.rb
echo "  def index; end" >> app/controllers/home_controller.rb
echo "end" >> app/controllers/home_controller.rb

mkdir -p app/views/home
touch app/views/home/index.html.erb

# Install
rails generate $INSTALL_NAME:install
rails $GEM_NAME:install:migrations db:migrate db:test:prepare
