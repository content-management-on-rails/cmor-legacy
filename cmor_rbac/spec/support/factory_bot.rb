require 'factory_bot_rails'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end

FactoryBot.factories.clear
FactoryBot.definition_file_paths += [
  Cmor::Rbac::Engine.root.join(*%w(spec factories)),
  Rails.root.join(*%w(spec factories))
]
FactoryBot.find_definitions