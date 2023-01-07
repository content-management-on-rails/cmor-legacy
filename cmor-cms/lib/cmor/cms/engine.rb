module Cmor::Cms
  class Engine < ::Rails::Engine
    isolate_namespace Cmor::Cms

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_bot, dir: "spec/factories"
    end

    initializer "cmor_cms_engine.register_template_handlers" do |app|
      require "cmor/cms/action_view/template/handlers/textile"
      ::ActionView::Template.register_template_handler :textile, ::ActionView::Template::Handlers::Textile.new
    end
  end
end
