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

# I18n configuration
touch config/initializers/i18n.rb
echo "Rails.application.config.i18n.available_locales = [:en, :de]" >> config/initializers/i18n.rb
echo "Rails.application.config.i18n.default_locale    = :de" >> config/initializers/i18n.rb

# I18n routing
touch config/initializers/route_translator.rb
echo "RouteTranslator.config do |config|" >> config/initializers/route_translator.rb
echo "  config.force_locale = true" >> config/initializers/route_translator.rb
echo "end" >> config/initializers/route_translator.rb

# Add ActiveStorage
# rails active_storage:install

# Add FrontendController needed by Cmor::Cms::PageController
touch app/controllers/frontend_controller.rb
echo "class FrontendController < ApplicationController" >> app/controllers/frontend_controller.rb
echo "end" >> app/controllers/frontend_controller.rb

# Add controller needed for template rendering specs
touch app/controllers/page_test_controller.rb
echo "class PageTestController < ApplicationController" >> app/controllers/page_test_controller.rb
echo "  include Cmor::Cms::ControllerExtensions::PageResolver" >> app/controllers/page_test_controller.rb
echo "  def index; end" >> app/controllers/page_test_controller.rb
echo "end" >> app/controllers/page_test_controller.rb
sed -i '2i\  localized { get "page_test", to: "page_test#index" }' config/routes.rb

# Add controller needed for partial rendering specs
touch app/controllers/partial_test_controller.rb
echo "class PartialTestController < ApplicationController" >> app/controllers/partial_test_controller.rb
echo "  include Cmor::Cms::ControllerExtensions::PageResolver" >> app/controllers/partial_test_controller.rb
echo "  include Cmor::Cms::ControllerExtensions::PartialResolver" >> app/controllers/partial_test_controller.rb
echo "  def index; end" >> app/controllers/partial_test_controller.rb
echo "end" >> app/controllers/partial_test_controller.rb
sed -i '2i\  localized { get "partial_test", to: "partial_test#index" }' config/routes.rb

# Install
rails generate $INSTALL_NAME:install
rails $GEM_NAME:install:migrations db:migrate db:test:prepare
