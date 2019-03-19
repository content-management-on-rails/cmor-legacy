module Cmor::Files::Backend
  module Configuration
    def configure
      yield self
    end

    mattr_accessor :registered_controllers do
      lambda do
        [
          Cmor::Files::Backend::FoldersController,
          Cmor::Files::Backend::FileDetailsController
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