require 'factory_bot_rails'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end

FactoryBot.factories.clear
FactoryBot.definition_file_paths << Rails.root.join(*%w(spec factories))
FactoryBot.definition_file_paths << Cmor::Blog::Engine.root.join(*%w(spec factories))
FactoryBot.definition_file_paths << Cmor::Cms::Engine.root.join(*%w(spec factories))
FactoryBot.definition_file_paths << Cmor::Contact::Engine.root.join(*%w(spec factories))
FactoryBot.definition_file_paths << Cmor::Carousels::Engine.root.join(*%w(spec factories))
FactoryBot.definition_file_paths << Cmor::Files::Engine.root.join(*%w(spec factories))
FactoryBot.definition_file_paths << Cmor::Galleries::Engine.root.join(*%w(spec factories))
FactoryBot.definition_file_paths << Cmor::Links::Engine.root.join(*%w(spec factories))
FactoryBot.definition_file_paths << Cmor::Partners::Engine.root.join(*%w(spec factories))
FactoryBot.definition_file_paths << Cmor::Rbac::Engine.root.join(*%w(spec factories))
FactoryBot.definition_file_paths << Cmor::Showcase::Engine.root.join(*%w(spec factories))
FactoryBot.definition_file_paths << Cmor::System::Backend::Engine.root.join(*%w(spec factories))
FactoryBot.definition_file_paths << Cmor::Tags::Engine.root.join(*%w(spec factories))
FactoryBot.definition_file_paths << Cmor::Testimonials::Engine.root.join(*%w(spec factories))
FactoryBot.definition_file_paths << Cmor::UserArea::Engine.root.join(*%w(spec factories))

FactoryBot.find_definitions