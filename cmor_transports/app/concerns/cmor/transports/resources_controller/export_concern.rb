module Cmor
  module Transports
    module ResourcesController
      module ExportConcern
        extend ActiveSupport::Concern

        included do
          before_action(only: :export) { initialize_export_for_export }
          before_action(only: :dump) { initialize_export_for_dump }

          helper_method :dump_path
          helper_method :export_path
        end

        def export; end
        def dump
          if @resource.aasm.fire!(:enqueue)
            respond_with(@resource, location: url_for([cmor_transports, @resource]))
          else
            render :export
          end
        end

        private

        def attributes_for_export
          resource_class.attribute_names
        end

        def initialize_export_for_export
          @resource = Cmor::Transports::Export.new(
            root_model: self.resource_class.to_s,
            output_attributes: attributes_for_export
          )
        end

        def initialize_export_for_dump
          @resource = Cmor::Transports::Export.new(permitted_params_for_dump.except('output_attributes')).tap do |resource|
            resource.output_attributes = permitted_params_for_dump['output_attributes'].reject { |e| e.empty? }
            resource.creator = current_user if respond_to?(:current_user)
            resource.query = load_collection_scope.all.to_sql
            resource.count_query = load_collection_scope.unscope(:order).select(Arel.star.count).to_sql
            resource.root_model = self.resource_class.to_s
            resource
          end
        end

        def dump_path
          url_for(request.GET.clone.merge(action: :dump, only_path: true))
        end

        def export_path
          url_for(request.GET.clone.merge(action: :export))
        end

        def permitted_params_for_dump
          params.require(:export).permit(:description, :output_format, output_attributes: [])
        end
      end
    end
  end
end
