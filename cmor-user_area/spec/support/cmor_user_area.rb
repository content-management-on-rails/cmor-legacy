require "cmor/user_area/spec_helpers/feature"

RSpec.configure do |config|
  config.include Cmor::UserArea::SpecHelpers::Feature, type: :feature
  config.include Cmor::UserArea::SpecHelpers::Feature, type: :system
end
