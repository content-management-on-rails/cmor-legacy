# Cmor::Contact
Short description and motivation.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'cmor_contact'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install cmor_contact
```

Install the initializer and routes:

  > rails g cmor:contact:install

Generate migrations and migrate:

  > rake cmor_contact:install:migrations
  > rake db:migrate

## Configuration

You can use the environment variable CMOR_CONTACT_RECIPIENTS to override the recipients in config/initializers/cmor_contact.rb

## Spam Protection

You can configure the spam protection in the initializer. Available options are:

* :hidden_field - Uses a hidden field as honeypot (default)
* :google_recaptcha_v2 - Google reCaptcha v2
* :google_recaptcha_v3 - Google reCaptcha v3

To use reCaptcha you have to add the recaptcha gem to you Gemfile:

    # Gemfile
    gem 'recaptcha'

Additionally you have to configure the google reCaptcha api keys. See the recaptcha documentation for futher information: [https://github.com/ambethia/recaptcha](https://github.com/ambethia/recaptcha).

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
