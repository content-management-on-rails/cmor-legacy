module Cmor
  module Core
    class Engine < ::Rails::Engine
      isolate_namespace Cmor::Core

      config.generators do |g|
        g.test_framework :rspec, fixture: true
        g.fixture_replacement :factory_girl, dir: 'spec/factories'
        # g.form_builder :simple_form
        # g.template_engine :haml
      end
    end
  end
end
