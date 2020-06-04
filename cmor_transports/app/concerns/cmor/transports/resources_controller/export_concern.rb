module Cmor
  module Transports
    module ResourcesController
      module ExportConcern
        extend ActiveSupport::Concern

        included do
          before_action(only: :export) { load_collection }
        end

        def export
          @resource = Cmor::Transports::Export.new(permitted_params_for_export)
          @resource.creator = current_user
          @resource.query = load_collection_scope.to_sql
          @resource.root_model = self.resource_class.to_s
          if @resource.aasm.fire!(:enqueue)
            flash[:success] = t('cmor.transports.exports.export.success', url: cmor_transports.url_for(@resource)).html_safe
          else
            flash[:error] = t('cmor.transports.exports.export.error')
          end
          respond_with(@resource, location: last_location)
        end

        def permitted_params_for_export
          params.require(:export).permit(:description, :output_format)
        end
      end
    end
  end
end
