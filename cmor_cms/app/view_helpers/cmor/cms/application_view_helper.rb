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
      def title
        "#{Cmor::Cms::Configuration.site_title} - #{c.content_for(:title)}"
      end

      def meta_description
        "<meta name=\"description\" content=\"#{c.content_for(:meta_description)}\">"
      end

      def link_to_top(icons: :glyphicons)
        render icons: icons
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
