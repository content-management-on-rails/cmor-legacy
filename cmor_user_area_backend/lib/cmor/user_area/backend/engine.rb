module Cmor
  module UserArea
    module Backend
      class Engine < ::Rails::Engine
        isolate_namespace Cmor::UserArea::Backend

        initializer "cmor_user_area_backend.asset_pipeline" do |app|
          app.config.assets.precompile << 'cmor_user_area_backend.js'
          app.config.assets.precompile << 'cmor_user_area_backend.css'
        end
      end
    end
  end
end
