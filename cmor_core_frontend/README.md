# Cmor::Frontend

Short description and motivation.

## Usage

How to use my plugin.

## Prerequisites

For correct pagination rendering you have to add kmaniari views via the correct gem.

For bootstrap 3:

    # Gemfile
    gem 'twitter-bootstrap-3'


For bootstrap 4:

    # Gemfile
    gem 'twitter-bootstrap-3'

Please ensure to set the correct pagination options (pagination_options_proc) as documented in the initializer.

## Installation

Add it to your gemfile:

    # Gemfile
    gem 'cmor_core_frontend'

Install bundle:

    > bundle install

Install initalizer and routes:

    > rails g cmor:core:frontend:install

## Adding a bootstrap 4 frontend

```bash
$ rails g cmor:core:frontend:bootstrap4
```

You will need to add the rails_eu_gdpr and rails-blueimp-gallery gems to use the generated frontend:

```ruby
gem 'rails-blueimp-gallery'
gem 'rails_eu_gdpr'
```

## Configuration

See the generated initializer in config/initializers/cmor_frontend.rb for configuration options.

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
