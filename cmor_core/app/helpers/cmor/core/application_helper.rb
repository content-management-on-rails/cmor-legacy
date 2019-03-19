module Cmor
  module Core
    module ApplicationHelper
      def bootstrap_paginate(objects, options = {})
        options.reverse_merge!(theme: 'twitter-bootstrap-3')

        paginate(objects, options)
      end

      # def mu(object, method)
      #   handler = object.send(method)
      #   erb_string = ::ERB.new(object[method.to_sym].to_s, 0).result(binding)
      #   handler.class.new(erb_string).to_html.html_safe
      # end
    end
  end
end
