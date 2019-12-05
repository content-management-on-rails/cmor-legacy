# frozen_string_literal: true
module Cmor
  module Api
    module Backend
      class Engine < ::Rails::Engine
        isolate_namespace Cmor::Api::Backend
      end
    end
  end
end
