# Cmor::Galleries

Adds support for picture galleries.

## Installation

Add it to your bundle:

```
# Gemfile:
gem 'cmor-galleries'
```

Install your bundle:

```
$> bundle install
```

Install the initializer:

```
$> rails g cmor:galleries:install
```

Generate migrations and migrate:

```
$> rails cmor:galleries:install:migrations
$> rails db:migrate
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
