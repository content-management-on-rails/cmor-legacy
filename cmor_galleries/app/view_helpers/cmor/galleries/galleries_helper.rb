module Cmor
  module Galleries
    # Usage:
    #
    #     # app/controllers/application_vontroller.rb
    #     class ApplicationController < ActionController::Base
    #       view_helper Cmor::Galleries::GalleriesHelper, as: :galleries_helper
    #       # ...
    #     end
    #
    #     # app/views/home/index.html.haml
    #     = galleries_helper(self).render(name: 'main', variant_options: { combine_options: { resize: "255x255^", extent: "255x255", gravity: "center"} }, show_details: true)
    #
    # Default options are taken from Cmor::Galleries::Configuration.galleries_helper_render_default_options.
    # You can set this option in the initializer.
    #
    class GalleriesHelper < Rao::ViewHelper::Base
      def render(options = {})
        options.reverse_merge!(Cmor::Galleries::Configuration.galleries_helper_render_default_options)
        
        name            = options.delete(:name)
        variant_options = options.delete(:variant_options)
        show_details    = options.delete(:show_details)
        
        resource = Cmor::Galleries::PictureGallery.where(name: name).first
        c.render partial: 'cmor/galleries/galleries_helper/render', locals: { resource: resource, variant_options: variant_options, show_details: show_details }
      end
    end
  end
end
