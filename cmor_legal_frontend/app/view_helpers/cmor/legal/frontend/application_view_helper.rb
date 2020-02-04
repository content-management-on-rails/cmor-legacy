# frozen_string_literal: true

module Cmor::Legal
  module Frontend
    # Example:
    #
    #     # app/controllers/application_controller.rb
    #     class ApplicationController < ActionController::Base
    #       view_helper Cmor::Legal::Frontend::ApplicationViewHelper, as: :legal_helper
    #     end
    #
    class ApplicationViewHelper < Rao::ViewHelper::Base
    end
  end
end
