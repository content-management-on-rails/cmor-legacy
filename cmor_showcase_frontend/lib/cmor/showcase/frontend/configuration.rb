module Cmor::Showcase::Frontend
  module Configuration
    def configure
      yield self
    end

    mattr_accessor(:base_controller) { '::FrontendController' }
    mattr_accessor(:default_render_items_variant_options) { { combine_options: { resize: "768x432^", gravity: :center, extent: "768x432" } } }
  end
end
