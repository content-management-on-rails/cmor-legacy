# Cmor::Seo::Frontend
Short description and motivation.

## Usage

Add the view helper to your controller:

# app/controllers/application_controller.rb
```
class ApplicationController < ActionController::Base
  view_helper Cmor::Seo::Frontend::ApplicationViewHelper, as: :seo_helper
  #...
end
```

Render meta tags in your layout:

```
# app/views/layouts/application.html.haml
!!!
  %html
    %head
      = seo_helper(self).render_meta_tags
```

## Installation

Add it to your bundle:

```
# Gemfile:
gem 'cmor_seo_frontend'
```

Install your bundle:

```
$> bundle install
```

Install the initializer:

```
$> rails g cmor:seo:frontend:install
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
