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

If you want full control of all installation options you may want to install
the modules one by one.

## Available modules

  * audits - Change auditing module (not installed by default) 
  * blog - Blogging module
  * carousels - Picture carousels
  * cms - Content management core module with layouts, pages, redirects, partials, navigations
  * contact - Provides a contact form.
  * core_backend - Core module that provides shared backend features
  * core_frontend - Core module that provides shared frontend features
  * files - Provides uploads/downloads
  * galleries - Picture galleries with lightbox support
  * legal - Provides a eu gdpr compiant cookie banner and integration of a privacy policy
  * links - Provides nested lists of links and a link footer
  * multi_tenancy - Provides multi tenancy across all modules (not installed by default)
  * partners - Provides a showcase and a slider for your business partners
  * rbac - Role based authorization framework with a nice admin interface
  * seo - Integration of seo feature like automatic sitemap generation, meta tags and micro formats
  * showcase - A showcase for your projects/products
  * system - A system insights dashbard for active storage, delayed job, changelogs, etc.
  * tags - A flexiable tagging solution for your models
  * testimonials - Display customer testimonials and opinions
  * transports - An import/export system for your business models (not installed by default) (work in progress)
  * user_area - User authentication

## Installation

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
