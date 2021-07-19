module Cmor::Showcase::Frontend
  module Configuration
    def configure
      yield self
    end

    mattr_accessor(:base_controller) { '::FrontendController' }
    mattr_accessor(:default_render_items_variant_options) { { resize: "768x432^", gravity: :center, extent: "768x432" } }
    mattr_accessor(:thumbnail_variant_options) { { resize: "384x216^", extent: "384x216", gravity: "center"} }
  end
end
