module Cmor::Transports
  module Configuration
    def configure
      yield self
    end

    mattr_accessor :resources_controllers do
      -> {[]}
    end

    mattr_accessor :resource_controllers do
      -> {[]}
    end

    mattr_accessor :service_controllers do
      -> {[]}
    end

    mattr_accessor :sidebar_controllers do
      -> {[]}
    end

    mattr_accessor :api_key do
      nil
    end

    mattr_accessor :export_formats do
      -> {{
        csv: "Cmor::Transports::Exports::CsvService",
        json: "Cmor::Transports::Exports::JsonService",
        yaml: "Cmor::Transports::Exports::YamlService",
      }}
    end

    mattr_accessor :factory_root_model_class_name do
      'Post'
    end
  end
end
