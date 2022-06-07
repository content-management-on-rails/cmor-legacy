$:.push File.expand_path("../lib", __FILE__)

require_relative "../lib/cmor/version"
require "cmor/core/api/gemspec"

Gem::Specification.new do |spec|
  Cmor::Core::Api::Gemspec.defaults(spec, load_self: false)
  
  spec.name        = "cmor-core-api"
  spec.summary     = "Core API module for CMOR."
  spec.add_dependency "bcrypt"
end
