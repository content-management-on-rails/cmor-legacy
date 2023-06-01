$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require_relative "../lib/cmor/version"
require "cmor/core/api/gemspec"

Gem::Specification.new do |spec|
  Cmor::Core::Api::Gemspec.defaults(spec, load_self: false)

  # rubocop:disable Layout/ExtraSpacing
  spec.name        = "cmor-core-api"
  spec.summary     = "Core API module for CMOR."
  # rubocop:enable Layout/ExtraSpacing

  spec.add_dependency "bcrypt"
end
