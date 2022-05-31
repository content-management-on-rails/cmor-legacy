# CMOR User Area

## Migration to 4.0.0

Defining after_sign_in_url in the controller is not supported anymore. Control
the after sign in location by configuring it in the initializer:

    # config/initalizers/cmor_user_area.rb
    Cmor::UserArea.configure do |config|
      config.after_sign_in_url = ->(controller) { last_location || main_app.root_path }
    end

## Installation

Add it to your Gemfile:

    # Gemfile
    gem 'cmor_user_area'

Add Migrations and migrate:

    > rails cmor_user_area:install:migrations && rails db:migrate

Optionally, create a default user (user@example.com/password):

    > rails cmor:user_area:create_user

## Run the generator

    > rails g cmor:user_area:install

This will add routes:

    # config/routes.rb
    mount Cmor::UserArea::Engine, at: '/'

And add current_user helpers to your application controller:

    # app/controllers/application_controller.rb
    include Cmor::UserArea::Controller::RedirectBackConcern
    include Cmor::UserArea::Controller::CurrentUserConcern

And it will add an initializer config/initializers/cmor_user_area.rb with the
configuration.

## Usage

to secure a controller, add following before_action:

    # app/controllers/my_secure_controller.rb
    before_action :authenticate_user!

When you visit any controller actions, you will be redirected to the sign in form.

## Adding helper methods

    # app/controllers/application_controller.rb
    include Cmor::UserArea::Controller::CurrentUserConcern

This gives you #current_user_session, #current_user, user_signed_in?

## Using the navigation helper

    # app/controllers/application_controller.rb
    view_helper Cmor::UserArea::ApplicationViewHelper, as: :user_area_helper

    # app/views/layouts/application.html.erb
    <%= user_area_helper(self).render_navigation %>

## Running Specs

    gem install bundler
    bundle
    ./initialize_dummy.sh
    rspec -f d

## License

This project rocks and uses MIT-LICENSE.
