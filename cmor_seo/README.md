# Cmor::Seo
Short description and motivation.

## Usage

### Automatic meta tag creation on model save

You configure Cmor::Seo to generate seo related meta tags automatically:

```
# config/initalizers/cmor_seo.rb
Cmor::Seo.configure do |config|
  config.add_resource(
    'Cmor::Blog::Post',
    meta_tags: -> {{
      # This hash configures the mapping between the resource and the meta tag that will be
      # automatically created/upated when the resource is saved.
      'description' => ->(resource) { { content: resource.title } },
      'og:title'    => ->(resource) { { content: resource.title } },
      'og:url'      => ->(resource) { { content: cmor_blog.url_for(resource) } },
    }},
    autocomplete_options: {
      scope: ->(term) { Cmor::Blog::Post.where("LOWER(title) LIKE :term", term: "%#{term.downcase}%") },
      id_method: :id,
      text_method: :title
    }
  )
```

Use config.add_resource(...) to configure the meta tag creation for any number of resources/models.

### Adding/Updating meta tags manually

You can add or update existing meta tags in the backend. If you override a meta tag that is configured
to be created/update automatically, it will be marked as manually changed and it will not be updated
automatically anymore. If you want it to be updated again, you will have to delete it manually.

## Installation

Add it to your bundle:

```
# Gemfile:
gem 'cmor_seo'
```

Install your bundle:

```
$> bundle install
```

Install the initializer:

```
$> rails g cmor:seo:install
```

Generate migrations and migrate:

```
$> rails cmor_seo:install:migrations
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
