module Cmor::Core::Api
  class RegisteredEngine
    if Rails.version < '7.0'
      include ActiveModel::Model
      include ActiveModel::Attributes
      include ActiveModel::AttributeAssignment
      include ActiveModel::Validations
      include ActiveModel::Conversion

      extend ActiveModel::Naming
      extend ActiveModel::Translation
    else
      include ActiveModel::API
    end
    
    include ActiveModel::Attributes
    include ActiveModel::Serializers::JSON

    attr_accessor :class_name,
                  :name,
                  :options,
                  :singular_resources,
                  :plural_resource,
                  :services,
                  :sidebars

    def plural_resources
       @plural_resources ||= engine_configuration&.resources_controllers&.call&.map do |rc|
         PluralResource.new(controller: rc)
       end || []
    end

    def engine_class
      @engine_class ||= class_name.constantize
    end

    def engine_configuration
      return unless namespace.const_defined?("Configuration")
      @engine_configuration ||= "#{namespace}::Configuration".constantize
    end

    def namespace
      class_name.deconstantize.constantize
    end

    def identifier
      engine_class.name.underscore.gsub("/", "-")
    end


    def singular_name
      @singular_name ||= I18n.t("activemodel.models.#{engine_class.to_s.underscore}.one")
    end

    def plural_name
      @singular_name ||= I18n.t("activemodel.models.#{engine_class.to_s.underscore}.other")
    end
  end
end
