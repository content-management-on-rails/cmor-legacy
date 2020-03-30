require 'factory_bot_rails'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end


FactoryBot.tap do |f|
  f.factories.clear
  f.definition_file_paths += [
    Rails.root.join(*%w(spec factories)),
    Cmor::MultiTenancy::Engine::root.join(*%w(spec factories))
  ]
  f.find_definitions
end
