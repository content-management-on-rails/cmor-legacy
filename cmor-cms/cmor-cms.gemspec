$LOAD_PATH.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require_relative "../lib/cmor/version"
require_relative "../cmor_core_backend/lib/cmor/core/backend/gemspec"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  Cmor::Core::Backend::Gemspec.defaults(spec)

  # rubocop:disable Layout/ExtraSpacing
  spec.name        = "cmor-cms"
  spec.summary     = "Cmor::Cms."
  spec.description = "Cmor::Cms Backend Module."
  # rubocop:enable Layout/ExtraSpacing

  spec.files = Dir["{app,config,db,lib,spec/factories,spec/files}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "acts_as_list"
  spec.add_dependency "acts_as_published"
  spec.add_dependency "awesome_nested_set"
  spec.add_dependency "rao-service"
  spec.add_dependency "RedCloth"
end
