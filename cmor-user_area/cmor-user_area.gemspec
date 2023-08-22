$LOAD_PATH.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require_relative "../lib/cmor/version"
require_relative "../cmor-core-backend/lib/cmor/core/backend/gemspec"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  Cmor::Core::Backend::Gemspec.defaults(spec)

  # rubocop:disable Layout/ExtraSpacing
  spec.name        = "cmor-user_area"
  spec.summary     = "Cmor::UserArea."
  spec.description = "Cmor::UserArea Backend Module."
  # rubocop:enable Layout/ExtraSpacing

  spec.files = Dir["{app,config,db,lib,spec/factories,spec/files}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "aasm"
  spec.add_dependency "authlogic"
  spec.add_dependency "bcrypt"
  spec.add_dependency "rao-service"
  spec.add_dependency "active_model_otp", ">= 2.1.1"
  spec.add_dependency "active_model_serializers"
end
