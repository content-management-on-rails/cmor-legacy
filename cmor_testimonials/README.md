# CMOR Testimonials

## Installation

Add it to your bundle:

  # Gemfile
  gem 'cmor_testimonials'

Update your bundle:

  #> bundle install

Install the module:

  #> rails g cmor:testimonials:install

Create migrations:

  #> rake cmor_testimonials:install:migrations

Migrate:

  #> rake db:migrate

## Usage

Add the view helper to your controller:

  # app/controllers/application_controller.rb
  class ApplicationController < ActionController::Base
    view_helper Cmor::Testimonials::ApplicationViewHelper, as: :testimonials_helper
    #...
  end

Use the helper to display a testimonial category:

  # app/views/layouts/application.html.erb
  <%= testimonials_helper(self).render_category(category_identifier) %>

## License

This project rocks and uses MIT-LICENSE.

