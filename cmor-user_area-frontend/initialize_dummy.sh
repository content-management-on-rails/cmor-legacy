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

# setup webpacker
sed -i '17i\require "webpacker"' config/application.rb
rails webpacker:install

# setup simple form
rails generate simple_form:install --bootstrap

# setup i18n
touch config/initializers/i18n.rb
echo "Rails.application.config.i18n.available_locales = [:en, :de]" >> config/initializers/i18n.rb
echo "Rails.application.config.i18n.default_locale    = :de" >> config/initializers/i18n.rb

# setup i18n routing
touch config/initializers/route_translator.rb
echo "RouteTranslator.config do |config|" >> config/initializers/route_translator.rb
echo "  config.force_locale = true" >> config/initializers/route_translator.rb
echo "end" >> config/initializers/route_translator.rb

# setup administrador
# rails generate administrador:install

# setup cmor_core
rails generate cmor:core:install

# setup cmor-core-frontend
rails generate cmor:core:frontend:install

# setup cmor-user_area
rails cmor_user_area:install:migrations
rails generate cmor:user_area:install

# setup database
rails db:migrate db:test:prepare

# setup cmor-user_area-frontend
rails generate cmor:user_area:frontend:install

# setup frontend
sed -i '2i\  view_helper Cmor::Core::ApplicationViewHelper, as: :core_helper' app/controllers/application_controller.rb
sed -i '3i\  view_helper Cmor::UserArea::Frontend::ApplicationViewHelper, as: :user_area_helper' app/controllers/application_controller.rb

sed -i '13i\    <%= user_area_helper(self).render_navigation %>' app/views/layouts/application.html.erb
sed -i '14i\    <%= core_helper(self).render_flash %>' app/views/layouts/application.html.erb

sed -i '3i\  localized { root to: "home#index" }' config/routes.rb

touch app/controllers/home_controller.rb
echo "class HomeController < ApplicationController" >> app/controllers/home_controller.rb
echo "  def index; end" >> app/controllers/home_controller.rb
echo "end" >> app/controllers/home_controller.rb

mkdir -p app/views/home
touch app/views/home/index.html.erb

# add application layout
cat <<EOT > app/views/layouts/application.html.erb
<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">

    <title>Dummy</title>
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %>
  </head>
  <body>
    <%= user_area_helper(self).render_navigation %>
    <%= core_helper(self).render_flash %>

    <%= yield %>

   <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
  </body>
</html>
EOT
