module Cmor
  module Core
    module Backend
      module HomeController
        class Base < Administrador::HomeController::Base
        # class Base < Cmor::Core::Backend::Configuration.home_controller_base_class_name.constantize
        #   include Administrador::Controller::EngineConcern
        #   include Administrador::Controller::ApplicationConcern

        #   layout 'administrador/application'

        #   before_action do
        #     append_view_path ActionView::FileSystemResolver.new(
        #       Administrador::Engine.root.join(*%w(app views)),
        #       "administrador/home_controller/base/:action{.:locale,}{.:formats,}{+:variants,}{.:handlers,}"
        #     )
        #   end

          def index; end
        end
      end
    end
  end
end