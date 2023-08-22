module Cmor
  module Core
    module ApplicationHelper
      def bootstrap_paginate(objects, options = {})
        options.reverse_merge!(theme: 'twitter-bootstrap-3')

        paginate(objects, options)
      end
    end
  end
end
