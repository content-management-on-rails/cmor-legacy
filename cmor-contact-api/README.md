# Cmor::Contact::Api

Headless api module for Cmor::Contact.

## Installation

Add it to your bundle:

```
# Gemfile:
gem 'cmor-contact-api'
```

Install your bundle:

```
$> bundle install
```

Install the initializer:

```
$> rails g cmor:contact:api:install
```

## Running specs

```
$> gem install bundler
$> bundle
$> cd spec/dummy && rake db:migrate RAILS_ENV=test && cd ../..
$> guard
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
