$LOAD_PATH.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require_relative "../../lib/cmor/version"
require_relative "../../cmor-core-api/lib/cmor/core/api/gemspec"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  Cmor::Core::Api::Gemspec.defaults(spec)

  # rubocop:disable Layout/ExtraSpacing
  spec.name        = "cmor-opening_times-api"
  spec.summary     = "Cmor::OpeningTimes::Api."
  spec.description = "Cmor::OpeningTimes API Module."
  # rubocop:enable Layout/ExtraSpacing

  spec.files = Dir["{app,config,db,lib,spec/factories,spec/files}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "cmor-opening_times"
  spec.add_dependency "rao-api-resources_controller"

  spec.add_development_dependency "guard-bundler"
  spec.add_development_dependency "guard-standardrb"
end