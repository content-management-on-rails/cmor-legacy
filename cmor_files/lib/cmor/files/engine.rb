module Cmor::Files
  class Engine < ::Rails::Engine
    isolate_namespace Cmor::Files

    config.generators do |g|
      g.test_framework      :rspec
      g.fixture_replacement :factory_bot, dir: 'spec/factories' 
    end

    # config.factory_bot.definition_file_paths =
    #   self.root.join(*%w(spec factories)) if defined?(FactoryBotRails)
  end
end
