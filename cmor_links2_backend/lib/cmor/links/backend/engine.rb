module Cmor
  module Links
    module Backend
      class Engine < ::Rails::Engine
        isolate_namespace Cmor::Links::Backend

        initializer 'cmor_links_backend.asset_pipeline' do |app|
          app.config.assets.precompile << 'cmor_links_backend.js'
          app.config.assets.precompile << 'cmor_links_backend.css'
        end
      end
    end
  end
end
