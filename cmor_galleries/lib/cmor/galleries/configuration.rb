module Cmor::Galleries
  module Configuration
    def configure
      yield self
    end

    mattr_accessor(:base_controller) { '::FrontendController' }
    mattr_accessor(:galleries_helper_render_default_options) { { variant_options: {}, show_details: false } }
    mattr_accessor(:pictures_helper_render_default_options) { { image_tag_only: true } }
    mattr_accessor(:thumbnail_variant_options) { { combine_options: { resize: "384x216^", extent: "384x216", gravity: "center"} } }
  end
end