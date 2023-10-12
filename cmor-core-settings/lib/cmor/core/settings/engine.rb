module Cmor
  module Core
    module Settings
      class Engine < ::Rails::Engine
        isolate_namespace Cmor::Core::Settings

        config.generators do |g|
          g.test_framework :rspec, fixture: true
          g.fixture_replacement :factory_bot, dir: 'spec/factories'
          # g.form_builder :simple_form
          # g.template_engine :haml
        end
      end
    end
  end
end
