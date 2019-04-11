# frozen_string_literal: true

module Frontend
  class ApplicationViewHelper < Rao::ViewHelper::Base
    def call_to_action
      c.render partial: "frontend/application_view_helper/call_to_action"
    end

    # Renders images as inline gallery with lightbox.
    #
    # Usage:
    #
    #     = frontend_helper(self).inline_gallery(Post.first.images, id: "first_post_images", variant_options: { resize: "700x450" })
    #
    # @images: array of ActiveStorage assets (images).
    def inline_gallery(images, options = {})
      return if images.nil? || images.empty?
      
      variant_options = options.delete(:variant_options) || { resize: "960x540" }
      id = options.delete(:id) || "inline-gallery-#{rand(36**8).to_s(36)}"
      c.render partial: 'frontend/application_view_helper/inline_gallery', locals: { id: id, images: images, variant_options: variant_options }
    end

    def target_groups
      c.render partial: 'frontend/application_view_helper/target_groups'
    end
    
    def pricing
      c.render partial: 'frontend/application_view_helper/pricing'
    end
    
    def about_us
      c.render partial: 'frontend/application_view_helper/about_us'
    end

    def our_team
      c.render partial: 'frontend/application_view_helper/our_team'
    end

    def copyright_message
      c.t('site.copyright_message', owner: c.t('site.owner'), to: Time.zone.now.year)
    end

    def home_title
      c.t('.home')
    end

    def main_logo_url
      "https://placeholder.pics/svg/36x36"
    end

    def body_html
      { class: body_classes }
    end

    private

    def body_classes
      [].compact.join(' ')
    end
  end
end
