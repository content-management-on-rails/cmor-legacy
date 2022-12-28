# Cmor::Seo

Adds meta tag and title support for resources and pages.

## Installation

Add it to your bundle:

```
# Gemfile:
gem 'cmor-blog'
```

Install your bundle:

```
$> bundle install
```

Install the initializer:

```
$> rails g cmor:blog:install
```

Generate migrations and migrate:

```
$> rails cmor:blog:install:migrations
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
