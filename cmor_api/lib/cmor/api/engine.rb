# frozen_string_literal: true
module Cmor
  module Api
    class Engine < ::Rails::Engine
      isolate_namespace Cmor::Api
    end
  end
end