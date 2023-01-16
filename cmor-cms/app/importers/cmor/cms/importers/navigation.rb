module Cmor
  module Cms
    module Importers
      class Navigation
        def initialize(yaml, _option = {})
          @navigations = nil
          @yaml = YAML.safe_load(yaml)
        end

        def build_navigations
          navigations = []
          if @yaml.respond_to?(:each)
            @yaml.each do |navigation_data|
              navigation = Cmor::Cms::Navigation.new(navigation_data)
              navigations << navigation
            end
          end
          navigations
        end

        def navigations
          @navigations ||= build_navigations
        end

        attr_reader :yaml
      end
    end
  end
end
