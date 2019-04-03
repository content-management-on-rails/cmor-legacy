module Cmor::Testimonials::Backend
  module Configuration
    def configure
      yield self
    end

    mattr_accessor :registered_resources do
      -> { [] }
    end

    mattr_accessor :registered_services do
      -> { [] }
    end
  end
end