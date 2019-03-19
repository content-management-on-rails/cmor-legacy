require 'factory_girl'

FactoryBot.definition_file_paths << Cmor::Contact::Engine.root.join(*%w(spec factories))
FactoryBot.definition_file_paths << Cmor::UserArea::Engine.root.join(*%w(spec factories))

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    FactoryBot.find_definitions
  end
end