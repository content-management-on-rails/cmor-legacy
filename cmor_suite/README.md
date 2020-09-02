# CMOR Suite

This is a meta gem that provides a way to install all cmor modules at once.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'cmor_suite', require: 'cmor/suite/all'
```

If you want to specify the modules that you use you can specify them in the
require statement:

```ruby
gem 'cmor_suite', require: %w[
  cmor_suite
  cmor_blog
  cmor_blog_backend
  cmor_carousels
  cmor_carousels_backend
  cmor_cms
  cmor_cms_backend
  cmor_contact
  cmor_contact_backend
  cmor_files
  cmor_files_backend
  cmor_galleries
  cmor_galleries_backend
  cmor_legal
  cmor_legal_frontend
  cmor_links
  cmor_links_backend
  cmor_partners
  cmor_partners_frontend
  cmor_rbac
  cmor_rbac_backend
  cmor_seo
  cmor_seo_frontend
  cmor_showcase
  cmor_showcase_frontend
  cmor_system
  cmor_tags
  cmor_tags_backend
  cmor_testimonials
  cmor_testimonials_backend
  cmor_user_area
  cmor_user_area_backend
]

```


And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install cmor_suite
```

install the initializer and needed configuration files.
```bash
$ rails g cmor:suite:install
```

This will install prerequisites and following modules:

  * blog
  * carousels
  * cms
  * contact
  * core
  * files
  * galleries
  * legal
  * links
  * partners
  * rbac
  * seo
  * showcase
  * system
  * tags
  * testimonials
  * user_area

This will not install following modules, as you may want to install them explicitly:

  * audits
  * multi_tenancy
  * transports

If you want to omit certain modules you can do so by using the exclude_modules flag:

```bash
$ rails g cmor:suite:install -e rbac user_area
```

This will not install the rbac and user_area modules.

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
