$LOAD_PATH.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require_relative "../lib/cmor/version"
require_relative "../cmor_core_frontend/lib/cmor/core/frontend/gemspec"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  Cmor::Core::Frontend::Gemspec.defaults(spec)

  # rubocop:disable Layout/ExtraSpacing
  spec.name        = "cmor-user_area-frontend"
  spec.summary     = "Cmor::UserArea Frontend."
  spec.description = "Cmor::UserArea Frontend Module."
  # rubocop:enable Layout/ExtraSpacing

  spec.files = Dir["{app,config,db,lib,spec/factories,spec/files}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "cmor-user_area"
  spec.add_dependency "rqrcode"
end
