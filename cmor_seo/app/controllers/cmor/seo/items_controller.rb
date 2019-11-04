module Cmor::Seo
  class ItemsController < Cmor::Core::Backend::ResourcesController::Base
    include Rao::ResourcesController::ActsAsPublishedConcern

    def self.resource_class
      Cmor::Seo::Item
    end

    module AutocompleteConcern
      extend ActiveSupport::Concern

      def autocomplete_resource
        resource_class_name = params[:resource_class_name]
        term                = params[:term] || ''
        resource_class      = resource_class_name.constantize

        autocomplete_options = autocomplete_options_for(resource_class_name)

        if autocomplete_options.present?
          resources = autocomplete_options[:scope].call(term).all

          results = resources.collect do |resource|
            { id: resource.send(autocomplete_options[:id_method]), text: resource.send(autocomplete_options[:text_method]) }
          end
        else
          results = []
        end

        respond_to do |format|
          format.json do
            render json: { results: results }
          end
        end
      end

      private

      def autocomplete_options_for(resource_class_name)
        Cmor::Seo::Configuration.items_resource_autocomplete_options[resource_class_name]
      end
    end

    include AutocompleteConcern

    private

    def load_collection_scope
      super.eager_load(:meta_tags)
    end

    def permitted_params
      params.require(:item).permit(:resource_type, :resource_id, :path, :published, meta_tags_attributes: [:id, :name, :content, :published, :_destroy])
    end
  end
end