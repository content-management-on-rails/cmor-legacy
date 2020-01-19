module Cmor
  module Galleries
    # Usage:
    #
    #     # app/controllers/application_vontroller.rb
    #     class ApplicationController < ActionController::Base
    #       view_helper Cmor::Galleries::PicturesHelper, as: :pictures_helper
    #       # ...
    #     end
    #
    #     # app/views/home/index.html.haml
    #     = pictures_helper(self).render(name: 'main', variant_options: { combine_options: { resize: "255x255^", extent: "255x255", gravity: "center"} }, show_details: true)
    #
    # Default options are taken from Cmor::Galleries::Configuration.pictures_helper_render_default_options.
    # You can set this option in the initializer.
    #
    # You can pass the image_tag_only option to render just the <img>-tag without a bootstrap card.
    #
    # You can pass the url_only options to render just the url to the picture without any tags.
    #
    class PicturesHelper < Rao::ViewHelper::Base
      def render(options = {})
        options.reverse_merge!(Cmor::Galleries::Configuration.pictures_helper_render_default_options)

        variant_options = options.delete(:variant_options) || {}
        show_details    = options.delete(:show_details)
        image_tag_only  = options.delete(:image_tag_only)
        url_only        = options.delete(:url_only)

        where_conditions = case
          when options.has_key?(:id)
            { id: options[:id] }
          when options.has_key?(:identifier)
            { identifier: options[:identifier] }
          end
        
        resource = if Rails.env.test? || Rails.env.development?
          Cmor::Galleries::PictureDetail.where(where_conditions).first!
        else
          Cmor::Galleries::PictureDetail.where(where_conditions).first
        end
        if url_only
          c.main_app.url_for(resource.asset.variant(variant_options))
        else
          c.render(partial: 'cmor/galleries/pictures_helper/render', locals: { resource: resource, variant_options: variant_options, show_details: show_details, image_tag_only: image_tag_only })
        end
      end
    end
  end
end
