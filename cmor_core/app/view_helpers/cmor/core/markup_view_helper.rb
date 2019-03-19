module Cmor
  module Core
    class MarkupViewHelper < Rao::ViewHelper::Base
      def render(object, method)
        handler = object.send(method)
        return if handler.nil?
        erb_string = ::ERB.new(object[method.to_sym].to_s, 0).result(binding)
        handler.class.new(erb_string).to_html.html_safe
      end
    end
  end
end
