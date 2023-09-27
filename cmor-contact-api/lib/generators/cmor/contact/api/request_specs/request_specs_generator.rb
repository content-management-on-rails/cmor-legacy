module Cmor
  module Contact
    module Api
      class RequestSpecsGenerator < Rails::Generators::Base
        desc 'Generates request specs'

        source_root Cmor::Contact::Api::Engine.root.join('spec')

        def generate_feature_specs
          directory 'requests', 'spec/requests'
        end
      end
    end
  end
end
