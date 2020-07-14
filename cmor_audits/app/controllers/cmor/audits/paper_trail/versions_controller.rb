# frozen_string_literal: true

module Cmor
  module Audits
    module PaperTrail
      class VersionsController < Cmor::Core::Backend::ResourcesController::Base
        def self.resource_class
          ::PaperTrail::Version
        end

        def self.engine_class
          ::Cmor::Audits
        end

        def self.available_rest_actions
          super - %i(new create edit update)
        end
      end
    end
  end
end
