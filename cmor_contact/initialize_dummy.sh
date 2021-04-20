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

rails active_storage:install
rails generate simple_form:install --bootstrap

# Add webpacker
# sed -i '17i\  require "webpacker"' config/application.rb

# Responders
sed -i '17i\require "responders"' config/application.rb

# I18n configuration
touch config/initializers/i18n.rb
echo "Rails.application.config.i18n.available_locales = [:en, :de]" >> config/initializers/i18n.rb
echo "Rails.application.config.i18n.default_locale    = :de" >> config/initializers/i18n.rb

# I18n routing
touch config/initializers/route_translator.rb
echo "RouteTranslator.config do |config|" >> config/initializers/route_translator.rb
echo "  config.force_locale = true" >> config/initializers/route_translator.rb
echo "end" >> config/initializers/route_translator.rb

# Spec setup
sed -i '2i\  view_helper Cmor::Contact::ApplicationViewHelper, as: :contact_helper' app/controllers/application_controller.rb
sed -i '15i\//= require cmor_contact' app/assets/javascripts/application.js
sed -i '13i\ *= require cmor_contact' app/assets/stylesheets/application.css
rails generate controller Welcome index
sed -i '3i\  root to: "welcome#index"' config/routes.rb
cat <<EOT > app/views/layouts/application.html.erb
<!DOCTYPE html>
<html lang="<%= I18n.locale %>">
  <head>
    <title>Dummy</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= stylesheet_link_tag    'application', media: 'all' %>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <!-- Font Awesome CSS -->
    <link crossorigin="anonymous" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" rel="stylesheet">

    <!-- jQuery JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

    <%= javascript_include_tag 'application' %>
  </head>

  <body>
    <%= yield %>
    <!-- Optional JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <%= contact_helper(self).render_contact_widget %>
    <%= contact_helper(self).prepare_contact_modal %>
  </body>
</html>
EOT

# Add application assets
echo "//= require rails-ujs" >> app/assets/javascripts/application.js
echo "//= require cmor_contact" >> app/assets/javascripts/application.js
echo "Rails.application.config.assets.precompile += %w( application.js )" >> config/initializers/assets.rb

# Install
rails generate $INSTALL_NAME:install
rails $GEM_NAME:install:migrations db:migrate db:test:prepare
