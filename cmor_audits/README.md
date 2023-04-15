# Cmor::Audits

Welcome to the Auditing module of our Content Management System (CMS). This module is designed to provide comprehensive tracking and logging of all activities related to content management within the CMS.

With our Auditing module, you can monitor and record all actions related to content creation, modification, deletion, and publishing. Every activity will be documented with information on the user who performed the action, the time and date it was performed, and the specific content that was affected.

The information collected by the Auditing module is available for authorized users, such as administrators or compliance officers, to review. This enables your organization to ensure that content is being managed in accordance with company policies and regulatory requirements.

In addition to tracking activities, the Auditing module provides features such as generating reports and notifications for specific events or activity patterns. This helps you identify potential security risks, such as unauthorized access or unusual content changes.

Our Auditing module is an essential tool for promoting accountability and transparency in content management within your CMS. With its comprehensive tracking and reporting capabilities, you can ensure that your content is being managed with the highest standards of quality and compliance.

## Usage

How to use my plugin.

## Prerequisites

Papertrail is used under the hoods to provide the low level auditing funcationality. If your app does not already use it, you will have to set it up first:

```ruby
$ rails generate paper_trail:install
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cmor_audits'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install cmor_audits
```

Install the initializer and routes:

```bash
$ rails g cmor:audits:install
```


## Contributing

Contribution directions go here.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
