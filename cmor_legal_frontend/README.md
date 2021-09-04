# Cmor::Legal::Frontend
Short description and motivation.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'cmor_legal_frontend'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install cmor_legal_frontend
```

Install the initializer and routes:

    > rails g cmor:legal:frontend:install

## Usage

### Rendering the cookie consent banner

    # app/views/layouts/application.html.haml
    = legal_helper(self).render_cookie_consent_banner

### Rendering content depending on accepted cookies

    # app/views/layouts/application.html.haml
    %head
      - legal_helper(self).cookie_preferences.accepted_cookies.each do |c|
        = render "frontend/cookies/#{c.identifier}/head"
    %body
      - legal_helper(self).cookie_preferences.accepted_cookies.each do |c|
        = render "frontend/cookies/#{c.identifier}/body"

## Migrating from rails_eu_gdpr_backend

Install cmor_legal and cmor_legal_frontend.

Move configuration options from config/initializers/eu_gdpr.rb to config/initializers/cmor_legal.rb.

Replace view helper integrations in controllers:

    # old:
    view_helper EuGdpr::ApplicationViewHelper, as: :eu_gdpr_helper

    # new:
    view_helper Cmor::Legal::Frontend::ApplicationViewHelper, as: :legal_helper

Replace view helper calls in views:

    # old:
    eu_gdpr_helper(self)

    # old:
    legal_helper(self)

Update privacy policies:

    Cmor::Legal::PrivacyPolicy.find_each do |model|
      model.update_column(:pathname, "/cmor/legal/")
      model.update_column(:basename, "privacy_policy")
      model.update_column(:body, model.body.gsub(/eu_gdpr_helper\(self\)/, "legal_helper(self)"))
    end

Remove config/initializers/eu_gdpr.rb and config/initializers/eu_gdpr_backend.rb.

Remove rails_eu_gdpr and rails_eu_gdpr_backend from your Gemfile and bundle.

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
