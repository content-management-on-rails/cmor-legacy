module Cmor
  module MultiTenancy
    class FeatureSpecsGenerator < Rails::Generators::Base
      desc "Generates feature specs"

      source_root Cmor::MultiTenancy::Engine.root.join("spec")

      def generate_feature_specs
        directory "features", "spec/features"
      end
    end
  end
end
