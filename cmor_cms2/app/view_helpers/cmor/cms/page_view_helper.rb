module Cmor
  module Cms
    # Usage:
    #
    #     # app/controllers/application_controller.rb
    #     class ApplicationController < ActionController::Base
    #       view_helper Cmor::Cms::PageViewHelper, as: :cms_page_helper
    #     end
    #
    class PageViewHelper < Rao::ViewHelper::Base
      def is_page?
        c.params[:action] == 'respond' && page_param.present?
      end

      def current?(page)
        is_page? && page_param.to_s == page.to_s
      end

      def current
        is_page? ? page_param.to_s : nil
      end

      def home?
        current?(:home)
      end

      private

      def page_param
        c.params[:page]
      end
    end
  end
end
