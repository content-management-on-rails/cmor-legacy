module Cmor
  module Cms
    module Backend
      class Engine < ::Rails::Engine
        isolate_namespace Cmor::Cms::Backend

        initializer 'cmor_cms_backend.asset_pipeline' do |app|
          app.config.assets.precompile << 'cmor_cms_backend.js'
          # app.config.assets.precompile << 'cmor_cms_backend.css'
        end
      end
    end
  end
end
