# Cmor::Cms::Api

Headless api module for Cmor::UserArea.

## Installation

Add it to your bundle:

```
# Gemfile:
gem 'cmor-cms-api'
```

Install your bundle:

```
$> bundle install
```

Install the initializer:

```
$> rails g cmor:cms:api:install
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
