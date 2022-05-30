module Cmor::Core::Api
  class PluralResource
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

    attr_accessor :controller

    def as_json(options = {})
      (options[:methods] ||= []).push(
        :base_path,
        :routes,
        :resource_class,
        :singular_name,
        :plural_name,
        :identifier
      )
      super(options)
    end

    def identifier
      @identifier ||= controller.name.underscore.chomp("_controller").gsub("/", "-")
    end

    def resource_class
      @resource_class ||= controller.resource_class
    end

    def singular_name
      resource_class.model_name.human
    end

    def plural_name
      resource_class.model_name.human(count: :other)
    end

    def base_path
      @base_path ||= router.url_for(controller: controller.name.underscore.chomp("_controller"), action: :index, only_path: true)
    end

    def engine_class_name
      @engine_class_name ||= "#{controller.name.deconstantize}::Engine"
    end

    def engine_class
      @engine_class ||= engine_class_name.constantize
    end

    def router
      @router ||= engine_class.routes
    end

    def engine_routes
      @engine_routes ||= router.routes.map { |r| {alias: r.name, path: r.path.spec.to_s, controller: r.defaults[:controller], action: r.defaults[:action]}}
    end

    def routes
      @routes ||= engine_routes.find_all { |r| r[:controller] == controller.name.underscore.chomp("_controller") }
    end
  end
end
