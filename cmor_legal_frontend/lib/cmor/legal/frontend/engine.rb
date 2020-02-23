# frozen_string_literal: true

module Cmor
  module Legal
    module Frontend
      class Engine < ::Rails::Engine
        isolate_namespace Cmor::Legal::Frontend
      end
    end
  end
end
