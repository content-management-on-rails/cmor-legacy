[![Travis CI](https://travis-ci.org/content-management-on-rails/cmor.svg?branch=master)](https://travis-ci.org/content-management-on-rails/cmor)
[![Coverage Status](https://coveralls.io/repos/github/content-management-on-rails/cmor/badge.svg?branch=master)](https://coveralls.io/github/content-management-on-rails/cmor?branch=master)
[![Maintainability](https://api.codeclimate.com/v1/badges/a71fdca73c85a22125dc/maintainability)](https://codeclimate.com/github/content-management-on-rails/cmor/maintainability)

# (C)ontent (m)anagement (o)n (r)ails a.k.a Seymore - Let's you see more and makes your content²!

CMOR is a content management system for ruby on rails.git 

## Usage
How to use my plugin.

## Architecture

CMOR modules live in the subfolders of this repository. Each module is a
separate gem that can be installed on its own. For convenience you can
install the cmor_suite gem. This will install all cmor modules at once.

See the README file in the cmor_suite folder for more information.

## Running all specs
```bash
$ bundle && ./rspec-all.sh
```

## Structuring modules

Functionality is separateted into modules. I.e. everything related to the blog is in the modules starting with cmor_blog.

## Structuring data

Most of the time things appear in categories/collection with items/resources. I.e. pictures are organized in galleries.

A collection should have at least following columns:

    locale
    identifier
    title
    description
    position
    slug
    published_at

Resources should have at least following columns:

    collection_id
    identifier
    title
    description
    position
    slug
    published_at

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
