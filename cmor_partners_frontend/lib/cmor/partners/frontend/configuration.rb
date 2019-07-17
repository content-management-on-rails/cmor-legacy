module Cmor::Partners::Frontend
  module Configuration
    def configure
      yield self
    end

    mattr_accessor(:base_controller) { '::FrontendController' }
    mattr_accessor(:default_render_partners_variant_options) { { resize: "512x256>", gravity: :center, extent: "512x256" } }
  end
end
