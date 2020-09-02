# CMOR Suite

This is a meta gem that provides a way to install all cmor modules at once.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'cmor_suite'
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
  * core
  * cms
  * contact
  * files
  * galleries
  * links
  * rbac
  * tags
  * user_area

If you want to omit certain modules you can do so by using the exclude_modules flag:

```bash
$ rails g cmor:suite:install -e rbac user_area
```

This will not install the rbac and user_area modules.

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
