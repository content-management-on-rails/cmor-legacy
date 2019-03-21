$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require_relative "../lib/cmor/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'cmor_blog'
  s.version     = ::Cmor::VERSION
  s.authors     = ['Roberto Vasquez Angel']
  s.email       = ['roberto@vasquez-angel.de']
  s.homepage    = 'https://github.com/robotex82/cmor_blog'
  s.summary     = 'Cmor::Blog.'
  s.description = 'Cmor::Blog Module.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib,spec}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']

  s.add_dependency 'rails', '>= 5.0.0'
  s.add_dependency 'cmor_core', "= #{Cmor::VERSION}"
  s.add_dependency 'acts_as_list'
  s.add_dependency 'acts_as_published'
  # s.add_dependency 'html2markdown'
  # s.add_dependency 'kaminari'
  # s.add_dependency 'kramdown'
  s.add_dependency 'friendly_id'
  # s.add_dependency 'cmor_comments'

  s.add_development_dependency 'sqlite3', '~> 1.3.6'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'rails-dummy'
  s.add_development_dependency 'rao-shoulda_matchers'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_bot_rails'
end
