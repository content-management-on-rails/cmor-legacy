$LOAD_PATH.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require_relative "../lib/cmor/version"
require_relative "../cmor_core_backend/lib/cmor/core/backend/gemspec"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  Cmor::Core::Backend::Gemspec.defaults(spec)

  # rubocop:disable Layout/ExtraSpacing
  spec.name        = "cmor-showcase"
  spec.summary     = "Cmor::Showcase."
  spec.description = "Cmor::Showcase Backend Module."
  # rubocop:enable Layout/ExtraSpacing

  spec.files = Dir["{app,config,db,lib,spec/factories,spec/files}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "active_storage_validations"
  spec.add_dependency "acts_as_list"
  spec.add_dependency "acts_as_published"
  spec.add_dependency "friendly_id"
  spec.add_dependency "markup-rails", ">= 0.0.2"
end
