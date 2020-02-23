# frozen_string_literal: true

module Cmor
  module Legal
    module Frontend
      module Configuration
        def configure
          yield self
        end

        mattr_accessor(:base_controller) { "::FrontendController" }
      end
    end
  end
end
