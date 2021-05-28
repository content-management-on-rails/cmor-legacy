#!/bin/bash

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

# I18n configuration
touch config/initializers/i18n.rb
echo "Rails.application.config.i18n.available_locales = [:en, :de]" >> config/initializers/i18n.rb
echo "Rails.application.config.i18n.default_locale    = :de" >> config/initializers/i18n.rb

# I18n routing
touch config/initializers/route_translator.rb
echo "RouteTranslator.config do |config|" >> config/initializers/route_translator.rb
echo "  config.force_locale = true" >> config/initializers/route_translator.rb
echo "end" >> config/initializers/route_translator.rb

# Turbolinks
sed -i "15irequire 'turbolinks'" config/application.rb

# Satisfy prerequisites
sed -i "15irequire 'cmor_cms'" config/application.rb
rails generate simple_form:install --bootstrap
rails generate administrador:install
rails generate cmor:core:install
rails generate cmor:core:backend:install
rails generate cmor:legal:install
# rails generate eu_gdpr:install
# rails generate cmor:cms:install
rails cmor_cms:install:migrations

# Root route
rails generate controller Home index foo --no-controller-specs --no-view-specs
sed -i "2i  get '/foo', to: 'home#foo'" config/routes.rb
sed -i "3i  root to: 'home#index'" config/routes.rb

# Application layout
tee app/views/layouts/application.html.erb > /dev/null <<EOT
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

    <%= stylesheet_link_tag    "application", media: "all" %>
    <%= javascript_include_tag "application" %>
  </head>
  <body>
    <% flash.each do |type, msg| %>
      <div>
        <%= msg %>
      </div>
    <% end %>
    <%= yield %>

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
  </body>
  <%= legal_helper(self).render_cookie_consent_banner %>
</html>
EOT

# Add application assets
echo "//= require cmor_legal_frontend" >> app/assets/javascripts/application.js
echo "Rails.application.config.assets.precompile += %w( application.js )" >> config/initializers/assets.rb

# Install gem
rails generate cmor:legal:frontend:install

# prepare spec database
rails db:migrate db:test:prepare