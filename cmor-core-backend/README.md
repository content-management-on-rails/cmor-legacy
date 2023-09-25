# Cmor::Core::Backend

Short description and motivation.

## Usage

How to use my plugin.

## Installation

Add it to your gemfile:

    # Gemfile
    gem 'cmor-core-backend'

Install bundle:

    > bundle install

Install initalizer and routes:

    > rails g cmor:core:backend:install

## About config.image_variant_options

If you get a "TypeError (no implicit conversion to float from string)" error when accessing thumbnails you might want to change the config.image_variant_options settings to the newer format.

Before:

    # config/initializers/cmor-core-backend.rb
    Cmor::Core::Backend.configure do |config|
      default: config.image_variant_options = {
                 gallery: { resize: "640x480" },
                 table:   { resize: "160x120" }
      }
    end

After:

    # config/initializers/cmor-core-backend.rb
    Cmor::Core::Backend.configure do |config|
      default: config.image_variant_options = {
                 gallery: { resize_to_fill: [640, 480] },
                 table:   { resize_to_fill: [160, 120] }
      }
    end

## Contributing

Contribution directions go here.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
