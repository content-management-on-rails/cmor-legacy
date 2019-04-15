module Cmor
  module Core
    # Example:
    #
    #     # app/controllers/application_controller.rb
    #     class ApplicationController < ActionController::Base
    #       view_helper Cmor::Core::MarkupViewHelper, as: :markup_helper
    #     end
    class MarkupViewHelper < Rao::ViewHelper::Base
      # Example:
      #
      #     = markup_helper(self).to_html(post, :body)
      def to_html(object, method)
        handler = object.send(method)
        return if handler.nil?
        erb_string = ::ERB.new(object[method.to_sym].to_s, 0).result(binding)
        handler.class.new(erb_string).to_html.html_safe
      end
    end
  end
end
