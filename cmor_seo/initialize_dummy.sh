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
rails generate $INSTALL_NAME:install
rails $GEM_NAME:install:migrations db:migrate db:test:prepare

# Conifgure Cmor::Seo
sed -i "2i\  config.add_resource(" config/initializers/cmor_seo.rb
sed -i "3i\    'Post'," config/initializers/cmor_seo.rb
sed -i "4i\    meta_tags: -> {{" config/initializers/cmor_seo.rb
sed -i "5i\      'description' => ->(resource) { { content: resource.title } }," config/initializers/cmor_seo.rb
sed -i "6i\      'og:title'    => ->(resource) { { content: resource.title } }," config/initializers/cmor_seo.rb
sed -i "7i\      'og:url'      => ->(resource) { { content: main_app.url_for(resource) } }," config/initializers/cmor_seo.rb
sed -i "8i\    }}," config/initializers/cmor_seo.rb
sed -i "9i\    autocomplete_options: {" config/initializers/cmor_seo.rb
sed -i "10i\      scope: ->(term) { Post.where(\"LOWER(title) LIKE :term\", term: \"%#{term.downcase}%\") }," config/initializers/cmor_seo.rb
sed -i "11i\      id_method: :id," config/initializers/cmor_seo.rb
sed -i "12i\      text_method: :title" config/initializers/cmor_seo.rb
sed -i "13i\    }" config/initializers/cmor_seo.rb
sed -i "14i\  )" config/initializers/cmor_seo.rb
sed -i "15i\ " config/initializers/cmor_seo.rb
sed -i "16i\  config.add_resource(" config/initializers/cmor_seo.rb
sed -i "17i\    'Page'," config/initializers/cmor_seo.rb
sed -i "18i\    meta_tags: -> {{" config/initializers/cmor_seo.rb
sed -i "19i\      'description' => ->(resource) { { content: resource.meta_description } }," config/initializers/cmor_seo.rb
sed -i "20i\      'og:title'    => ->(resource) { { content: resource.title } }," config/initializers/cmor_seo.rb
sed -i "21i\    }}," config/initializers/cmor_seo.rb
sed -i "22i\    autocomplete_options: {" config/initializers/cmor_seo.rb
sed -i "23i\      scope: ->(term) { Page.where(\"LOWER(title) LIKE :term\", term: \"%#{term.downcase}%\") }," config/initializers/cmor_seo.rb
sed -i "24i\      id_method: :id," config/initializers/cmor_seo.rb
sed -i "25i\      text_method: :title" config/initializers/cmor_seo.rb
sed -i "26i\    }" config/initializers/cmor_seo.rb
sed -i "27i\  )" config/initializers/cmor_seo.rb
