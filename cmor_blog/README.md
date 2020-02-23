# Cmor::Blog
Short description and motivation.

## Usage
How to use my plugin.

## Prerequisites

For correct pagination rendering you have to add kmaniari views via the correct gem.

For bootstrap 3:

    # Gemfile
    gem 'twitter-bootstrap-3'


For bootstrap 4:

    # Gemfile
    gem 'twitter-bootstrap-3'

Please ensure to set the correct pagination options (pagination_options_proc) as documented in the initializer.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'cmor_blog'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install cmor_blog
```

Add migrations and migrate:

```bash
$ rake cmor_blog:install:migrations && rake db:migrate
```

Install routes and initializer:

```bash
$ rails g cmor:blog:install
```

## Updating to 1.3.0

Version 1.3.0 brings you positionable posts via acts_as_list. You have to migrate and initialize the post positions like this:

```bash
$ rake cmor_blog:install:migrations db:migrate cmor:blog:initialize_post_positions
```

## Updating to 0.0.45.pre

0.0.45.pre makes post creators optional. Configuration.creator_label_method_name is replaced by Configuration.creator_label_for_post_proc(post). You have to remove config.creator_label_method_name from config/initializers/cmor_blog and replace it:

Assume you had the following:

    # config/initializers/cmor_blog.rb
    Cmor::Blog.configure do |config|
      config.creator_label_method_name = :to_s
    end

Replace it with:

    # config/initializers/cmor_blog.rb
    Cmor::Blog.configure do |config|
      config.creator_label_for_post_proc = -> (post) { post.creator.to_s }
    end

## Configuration

See the generated initializer in config/initializers/cmor_blog.rb for configuration options.

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
