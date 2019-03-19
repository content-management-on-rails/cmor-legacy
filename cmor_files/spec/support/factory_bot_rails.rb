require 'factory_bot_rails'

FactoryBot = FactoryBot

# FactoryBot.definition_file_paths << Cmor::Blorgh::Engine.root.join(*%w(spec factories))
# FactoryBot.factories.clear
# FactoryBot.find_definitions

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
