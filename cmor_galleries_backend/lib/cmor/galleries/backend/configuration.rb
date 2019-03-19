module Cmor::Galleries::Backend
  module Configuration
    def configure
      yield self
    end

    mattr_accessor :registered_controllers do
      lambda do
        [
          Cmor::Galleries::Backend::PictureGalleriesController,
          Cmor::Galleries::Backend::PictureDetailsController
        ]
      end
    end

    mattr_accessor :registered_services do
      lambda do
        []
      end
    end
  end
end