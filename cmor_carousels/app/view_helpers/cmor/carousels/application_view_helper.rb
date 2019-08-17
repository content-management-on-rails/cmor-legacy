module Cmor
  module Carousels
    # Usage:
    #
    #     # app/controllers/application_controller.rb
    #     class ApplicationController < ActionController::Base
    #       view_helper Cmor::Carousels::ApplicationViewHelper, as: :carousels_helper
    #     end
    #
    class ApplicationViewHelper < Rao::ViewHelper::Base
      # Example:
      #
      #     # This will render a bootstrap 4 compatible carousel
      #     = carousels_helper(self).render_carousel(:main, autostart: true, interval: 5.0, variant_options: { resize: "1920x1080" })
      #
      def render_carousel(identifier, options = {})
        options.reverse_merge!(autostart: true, interval: 5.0, keyboard: true, pause: :hover, ride: false, wrap: true, controls: true, indicators: true, video_html_options: {})
        carousel_options = options.slice(:autostart, :interval, :pause, :ride, :wrap)
        video_html_options = options.delete(:video_html_options).reverse_merge!(autoplay: true, muted: true)
        data_attributes = carousel_options_to_data_attributes(carousel_options)

        carousel = Cmor::Carousels::Carousel.where(identifier: identifier.to_s).for_locale(I18n.locale).first

        if carousel.nil?
          return I18n.t('cmor.carousels.carousel.warnings.not_found', identifier: identifier)
        else
          variant_options = options.delete(:variant_options) || carousel.variant_options
          render carousel: carousel, options: options, data_attributes: data_attributes, variant_options: variant_options, video_html_options: video_html_options
        end
      end

      private

      def carousel_options_to_data_attributes(carousel_options)
        carousel_options.collect { |k,v| "\"data-#{k.to_s.dasherize}\"=#{v}" }.join(" ")
      end
    end
  end
end
