module Cmor
  module Cms
    # Usage:
    #
    #     # app/controllers/application_controller.rb
    #     class ApplicationController < ActionController::Base
    #       view_helper Cmor::Cms::ApplicationViewHelper, as: :cms_helper
    #     end
    #
    class ApplicationViewHelper < Rao::ViewHelper::Base
      def link_to_top
        c.render partial: '/cmor/cms/link_to_top'
      end

      def is_page?
        params[:action] == 'respond' && params.has_key?(:page)
      end

      def current_page?(page)
        cms_page? && params[:page].to_s == page.to_s
      end

      def current_page
        cms_page? ? params[:page].to_s : nil
      end
    end
  end
end
