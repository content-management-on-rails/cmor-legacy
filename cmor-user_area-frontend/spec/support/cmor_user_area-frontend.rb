require "cmor/user_area/frontend/spec_helpers/feature"

RSpec.configure do |config|
  config.include Cmor::UserArea::Frontend::SpecHelpers::Feature, type: :feature
  config.include Cmor::UserArea::Frontend::SpecHelpers::Feature, type: :system
end
