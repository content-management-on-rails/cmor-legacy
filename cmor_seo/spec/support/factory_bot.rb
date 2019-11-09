# frozen_string_literal: true

require "factory_bot_rails"

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end

FactoryBot.factories.clear
FactoryBot.definition_file_paths += [Cmor::Seo::Engine.root.join(*%w(spec factories))]
FactoryBot.definition_file_paths += [Rails.root.join(*%w(spec factories))]
FactoryBot.find_definitions
