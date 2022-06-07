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

# Add ActiveStorage
rails active_storage:install

# Add User model for userstamping
rails g model User email
sed -i '2i\  private' app/controllers/application_controller.rb
sed -i '3i\  ' app/controllers/application_controller.rb
sed -i '4i\  def current_user' app/controllers/application_controller.rb
sed -i '5i\    User.first_or_create!(email: "jane.doe@domain.local")' app/controllers/application_controller.rb
sed -i '6i\  end' app/controllers/application_controller.rb

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
sed -i "16irequire 'factory_bot_rails'" config/application.rb

# Install administrador
rails generate administrador:install

# Install SimpleForm
rails generate simple_form:install --bootstrap

# Install cmor_core_backend
rails g cmor:core:backend:install

# Setup sepcs
rails g scaffold Post title body:text published_at:timestamp --no-test-framework
rails g factory_bot:model Post title body:text published_at:timestamp
rails g scaffold Page title meta_description body:text published_at:timestamp --no-test-framework
rails g factory_bot:model Page title meta_description body:text published_at:timestamp

# Install
rails generate cmor:seo:install
rails cmor_seo:install:migrations db:migrate db:test:prepare

# Conifgure Cmor::Seo
sed -i "2i\  config.add_resource(" config/initializers/cmor_seo.rb
sed -i "3i\    'Post'," config/initializers/cmor_seo.rb
sed -i "4i\    title: ->(resource) { resource.title }," config/initializers/cmor_seo.rb
sed -i "5i\    meta_tags: -> {{" config/initializers/cmor_seo.rb
sed -i "6i\      'description' => ->(resource) { { content: resource.title } }," config/initializers/cmor_seo.rb
sed -i "7i\      'og:title'    => ->(resource) { { content: resource.title } }," config/initializers/cmor_seo.rb
sed -i "8i\      'og:url'      => ->(resource) { { content: main_app.url_for(resource) } }," config/initializers/cmor_seo.rb
sed -i "9i\    }}," config/initializers/cmor_seo.rb
sed -i "10i\    autocomplete_options: {" config/initializers/cmor_seo.rb
sed -i "11i\      scope: ->(term) { Post.where(\"LOWER(title) LIKE :term\", term: \"%#{term.downcase}%\") }," config/initializers/cmor_seo.rb
sed -i "12i\      id_method: :id," config/initializers/cmor_seo.rb
sed -i "13i\      text_method: :title" config/initializers/cmor_seo.rb
sed -i "14i\    }" config/initializers/cmor_seo.rb
sed -i "15i\  )" config/initializers/cmor_seo.rb
sed -i "16i\ " config/initializers/cmor_seo.rb
sed -i "17i\  config.add_resource(" config/initializers/cmor_seo.rb
sed -i "18i\    'Page'," config/initializers/cmor_seo.rb
sed -i "19i\    title: ->(resource) { resource.title }," config/initializers/cmor_seo.rb
sed -i "20i\    meta_tags: -> {{" config/initializers/cmor_seo.rb
sed -i "21i\      'description' => ->(resource) { { content: resource.meta_description } }," config/initializers/cmor_seo.rb
sed -i "22i\      'og:title'    => ->(resource) { { content: resource.title } }," config/initializers/cmor_seo.rb
sed -i "23i\    }}," config/initializers/cmor_seo.rb
sed -i "24i\    autocomplete_options: {" config/initializers/cmor_seo.rb
sed -i "25i\      scope: ->(term) { Page.where(\"LOWER(title) LIKE :term\", term: \"%#{term.downcase}%\") }," config/initializers/cmor_seo.rb
sed -i "26i\      id_method: :id," config/initializers/cmor_seo.rb
sed -i "27i\      text_method: :title" config/initializers/cmor_seo.rb
sed -i "28i\    }" config/initializers/cmor_seo.rb
sed -i "29i\  )" config/initializers/cmor_seo.rb
