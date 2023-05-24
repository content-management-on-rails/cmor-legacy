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

# responders for rao-service_controller
# sed -i '17i\  require "responders"' config/application.rb

## Always require rspec and factory_bot_rails in dummy app
sed -i '17i\  require "rspec-rails"' config/application.rb
sed -i '17i\  require "factory_bot_rails"' config/application.rb

## I18n configuration
touch config/initializers/i18n.rb
echo "Rails.application.config.i18n.available_locales = [:en, :de]" >> config/initializers/i18n.rb
echo "Rails.application.config.i18n.default_locale    = :de" >> config/initializers/i18n.rb

## I18n routing
# touch config/initializers/route_translator.rb
# echo "RouteTranslator.config do |config|" >> config/initializers/route_translator.rb
# echo "  config.force_locale = true" >> config/initializers/route_translator.rb
# echo "end" >> config/initializers/route_translator.rb

# Install administrador
# rails generate administrador:install

# Install SimpleForm
# rails generate simple_form:install --bootstrap

# Add DelayedJob::ActiveRecord
# sed -i '17i\  require "delayed_job_active_record"' config/application.rb
# rails generate delayed_job:active_record

# Add ActiveStorage
# rails active_storage:install

# Example models for specs
rails g model Post title body:text
rails g model Comment post:references body:text

# Example controller for specs

echo "class PostsController < ActionController::API" >> app/controllers/posts_controller.rb
echo "  include Cmor::Core::Api::Controllers::TokenAuthenticationConcern" >> app/controllers/posts_controller.rb
echo "  include Cmor::Core::Api::Controllers::WriteAuthorizationConcern" >> app/controllers/posts_controller.rb
echo "" >> app/controllers/posts_controller.rb
echo "  before_action :authenticate_with_token!" >> app/controllers/posts_controller.rb
echo "  before_action :authorize_write!, only: [:create, :update, :destroy]" >> app/controllers/posts_controller.rb
echo "" >> app/controllers/posts_controller.rb
echo "  def index" >> app/controllers/posts_controller.rb
echo "    render json: Post.all" >> app/controllers/posts_controller.rb
echo "  end" >> app/controllers/posts_controller.rb
echo "" >> app/controllers/posts_controller.rb
echo "  def show" >> app/controllers/posts_controller.rb
echo "    render json: Post.find(params[:id])" >> app/controllers/posts_controller.rb
echo "  end" >> app/controllers/posts_controller.rb
echo "" >> app/controllers/posts_controller.rb
echo "  def create" >> app/controllers/posts_controller.rb
echo "    post = Post.create(permitted_params)" >> app/controllers/posts_controller.rb
echo "    render json: post" >> app/controllers/posts_controller.rb
echo "  end" >> app/controllers/posts_controller.rb
echo "" >> app/controllers/posts_controller.rb
echo "  def update" >> app/controllers/posts_controller.rb
echo "    post = Post.find(params[:id])" >> app/controllers/posts_controller.rb
echo "    post.update_attributes(post_params)" >> app/controllers/posts_controller.rb
echo "    render json: post" >> app/controllers/posts_controller.rb
echo "  end" >> app/controllers/posts_controller.rb
echo "" >> app/controllers/posts_controller.rb
echo "  def destroy" >> app/controllers/posts_controller.rb
echo "    Post.destroy(params[:id])" >> app/controllers/posts_controller.rb
echo "  end" >> app/controllers/posts_controller.rb
echo "" >> app/controllers/posts_controller.rb
echo "  private " >> app/controllers/posts_controller.rb
echo "" >> app/controllers/posts_controller.rb
echo "  def permitted_params" >> app/controllers/posts_controller.rb
echo "    params.require(:post).permit(:title, :body)" >> app/controllers/posts_controller.rb
echo "  end" >> app/controllers/posts_controller.rb
echo "end" >> app/controllers/posts_controller.rb

sed -i '2i\  resources :posts' config/routes.rb

# rails db:migrate db:test:prepare

# Setup ActiveRecord encryption
rails db:encryption:init

# Install
rails generate cmor:core:api:install
rails cmor_core_api:install:migrations
rails db:migrate db:test:prepare