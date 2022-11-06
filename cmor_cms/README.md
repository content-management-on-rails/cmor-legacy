# Cmor::Cms

## End-User documentation

Please look at the[link:doc] Folder.

## Upgrading to 0.0.61.pre

### Add Redirects

You can now add redirects for specific paths. This feature is backed by a new model Cmor::Cms::Redirect. You need to add the new table to the database:

    #> rake cmor_cms:install:migrations && rake db:migrate

### Cmor::Cms::Configuration #site_title is replaced by #page_title.

Before:

    # config/initializers/cmor_cms.rb
    Cmor::Cms.configure do |config|
      # Sets the site title
      #
      # Default: config.site_title = Rails.application.class.to_s.deconstantize
      #
      config.site_title = Rails.application.class.to_s.deconstantize
    end

After:

    # config/initializers/cmor_cms.rb
    Cmor::Cms.configure do |config|
      # Sets the page title that is used in the html title tag.
      #
      # Default: config.page_title = ->(context) { [context.content_for(:title), "My Page"].compact.join(" - ") }
      #
      config.page_title = ->(context) { [context.content_for(:title), Rails.application.class.to_s.deconstantize].compact.join(" - ") }
    end

## Installation

Add it to your bundle:

    # Gemfile:
    gem 'cmor_cms'

Install your bundle:

    #> bundle install

Install the intializer:

   #> rails g cmor:cms:install

Generate migrations and migrate:

    #> rake cmor_cms:install:migrations
    #> rake db:migrate

## Optional: Generating example/default data

There is a task to prepopulate your database tables with example data.

Warning: *RUNNING THIS WILL DELETE ALL OF YOUR CMS DATA AND REPLACE IT WITH EXAMPLE DATA!*

    #> rake cmor:cms:db:populate!

## Linking to pages

    <%= link_to 'My Page', page_path(i18n_locale: I18n.locale, page: 'my-page') %>

## Using partials form the database in other controllers

    # app/controllers/application_controller.rb
    class ApplicationController < ActionController::Base
      prepend_view_path ::Cmor::Cms::PartialResolver.instance
      ...
    end

## Using the navigation helper

    # app/controllers/application_controller.rb
    class ApplicationController < ActionController::Base
      helper Cmor::CmsHelper
      ...
    end

Then you can render navigation in your views:

    # app/views/_navigation.rb
    = cms_render_navigation(:main)

## Running specs

    gem install bundler
    bundle
    cd spec/dummy && rake db:migrate RAILS_ENV=test && cd ../..
    guard

## License

This project rocks and uses MIT-LICENSE.
