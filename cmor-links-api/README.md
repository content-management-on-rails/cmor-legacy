# Cmor::Links::Api

Headless api module for Cmor::Links.

## Installation

Add it to your bundle:

```
# Gemfile:
gem 'cmor-links-api'
```

Install your bundle:

```
$> bundle install
```

Install the initializer:

```
$> rails g cmor:links:api:install
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
