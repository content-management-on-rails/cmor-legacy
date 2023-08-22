module <%= name %>
  module Configuration
    def configure
      yield self
    end

    mattr_accessor(:base_controller) { '::FrontendController' }
  end
end
