require "rao/shoulda/matchers"

RSpec.configure do |config|
  config.include Rao::Shoulda::Matchers, type: :feature
end
