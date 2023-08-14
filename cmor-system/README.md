# Cmor::System

Short description and motivation.

## Upgrading to 0.0.61.pre

We changed the namespace of the delayed jobs controller. If you are using the
delayed jobs backend, you have to change the namespace in the initializer:

    # config/initializers/cmor_system.rb
    Cmor::System.configure do |config|
      config.registered_controllers = -> {[
        # This was Cmor::System::DelayedBackendActiveRecord::JobsController before.
        Cmor::System::Delayed::Backend::ActiveRecord::JobsController,
        #...
      ]}
      #...
    end

## Upgrading to 0.0.44.pre

cmor_system_backend was renamed to cmor_system. You need to do following things after upgrading:

1. Rename config/initializers/cmor_system_backend.rb to config/initializers/cmor_system.rb and change Cmor::System::Backend to Cmor::System.

## Usage

How to use my plugin.

## Installation

Add it to your gemfile:

    # Gemfile
    gem 'cmor_system'

Install bundle:

    > bundle install

Install initalizer and routes:

    > rails g cmor:system:install

## Contributing

Contribution directions go here.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
