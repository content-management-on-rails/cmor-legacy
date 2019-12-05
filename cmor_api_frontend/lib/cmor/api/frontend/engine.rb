# frozen_string_literal: true
module Cmor
  module Api
    module Frontend
      class Engine < ::Rails::Engine
        isolate_namespace Cmor::Api::Frontend
      end
    end
  end
end
