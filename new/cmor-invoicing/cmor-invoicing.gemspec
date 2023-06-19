$LOAD_PATH.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require_relative "../../lib/cmor/version"
require_relative "../../cmor_core_backend/lib/cmor/core/backend/gemspec"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  Cmor::Core::Backend::Gemspec.defaults(spec)

  # rubocop:disable Layout/ExtraSpacing
  spec.name        = "cmor-invoicing"
  spec.summary     = "Cmor::Invoicing."
  spec.description = "Cmor::Invoicing Backend Module."
  # rubocop:enable Layout/ExtraSpacing

  spec.files = Dir["{app,config,db,lib,spec/factories,spec/files}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "money-rails"
  spec.add_dependency "wicked_pdf"
  spec.add_dependency "wkhtmltopdf-binary"
  spec.add_dependency "rao-service"
end
