# Cmor::Core::Api

Provides api core functionality like discovery of available REST endpoints.

## Usage

How to use my plugin.

## Prerequisites

You need to enable ActiveRecord encryption. See https://guides.rubyonrails.org/active_record_encryption.html

TL;DR: If you haven't used ActiveRecord encryption in you project until now, set it up by running:

    > rails db:encryption:init

## Installation

Add this line to your application's Gemfile:

```ruby
gem "cmor-core-api"
```

And then execute:

```bash
$ bundle
```

Generate the initializers with the configuration:

```bash
$ rails g cmor:core:api:install
```

### Registering engines

To add api endpoints you will have to register the engines that include them:

    # config/initializers/cmor-core-api.rb

### Querying existing endpoints

### Querying resources (CRUDL)

### GET index

### Localization

## Contributing

Contribution directions go here.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
