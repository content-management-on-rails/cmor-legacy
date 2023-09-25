module Cmor
  module Core
    module Api
      module Backend
        class FeatureSpecsGenerator < Rails::Generators::Base
          desc 'Generates feature specs'

          source_root Cmor::Core::Api::Backend::Engine.root.join('spec')

          def generate_feature_specs
            directory 'features', 'spec/features'
          end
        end
      end
    end
  end
end
