module Cmor
  module Files
    module Backend
      class AttachmentsController < Cmor::Core::Backend::ResourcesController::Base
        include Rao::ResourcesController::SortingConcern
        include Rao::ResourcesController::BatchActionsConcern

        def self.resource_class
          ActiveStorage::Attachment
        end

        # def destroy_many
        #   @collection = load_collection_scope.where(id: params[:ids])
        #   @collection.destroy_all

        #   respond_with @collection, location: after_destroy_many_location, noticse: t('.success')
        # end

        # def publish_many
        #   @collection = load_collection_scope.where(id: params[:ids])
        #   @collection.map(&:publish!)

        #   respond_with @collection, location: last_location, noticse: t('.success')
        # end

        # def unpublish_many
        #   @collection = load_collection_scope.where(id: params[:ids])
        #   @collection.map(&:unpublish!)

        #   respond_with @collection, location: last_location, noticse: t('.success')
        # end

        private

        def after_destroy_many_location
          last_location
        end

        def permitted_params
          params.require(:attachment).permit()
        end
      end
    end
  end
end
