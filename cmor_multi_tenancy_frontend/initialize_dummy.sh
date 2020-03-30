#!/bin/bash
GEM_NAME=cmor_multi_tenancy_frontend
INSTALL_NAME=cmor:multi_tenancy:frontend

# Delete old dummy app
rm -rf spec/dummy

# Generate new dummy app
DISABLE_MIGRATE=true rake dummy:app

if [ ! -d "spec/dummy" ]; then
  echo "Dummy app was not generated. Exiting..."
  exit 1
fi

rm spec/dummy/.ruby-version

# Satisfy prerequisites
cd spec/dummy

# Use correct Gemfile
rm Gemfile
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

rails generate cmor:multi_tenancy:install
rails cmor_multi_tenancy:install:migrations db:migrate db:test:prepare

# Install
rails generate $INSTALL_NAME:install

# Customize dummy app
rails generate controller Home index --no-helper --no-assets --no-request-specs --no-controller-specs --no-view-specs
sed -i "2i  include Cmor::MultiTenancy::Controller::CurrentClientConcern" app/controllers/application_controller.rb
echo "= current_client.title" >> app/views/home/index.html.haml

cat <<EOT > config/routes.rb
Rails.application.routes.draw do

  localized do
    scope path: "(/:client_identifier)" do
      root to: 'home#index'
    end
    mount Cmor::MultiTenancy::Engine, at: '/backend/cmor-multi-tenancy-engine'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
EOT