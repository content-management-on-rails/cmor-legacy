$LOAD_PATH.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require_relative "../lib/cmor/version"
require_relative "../cmor-core-api/lib/cmor/core/api/gemspec"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  Cmor::Core::Api::Gemspec.defaults(spec)

  # rubocop:disable Layout/ExtraSpacing
  spec.name        = "cmor-blog-api"
  spec.summary     = "Cmor::Blog::Api."
  spec.description = "Cmor::Blog API Module."
  # rubocop:enable Layout/ExtraSpacing

  spec.files = Dir["{app,config,db,lib,spec/factories,spec/files}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  spec.add_dependency "cmor-blog"
  spec.add_dependency "rao-api-resources_controller"
end
