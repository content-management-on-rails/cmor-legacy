module Cmor
  module Audits
    module ResourcesController
      module PaperTrailConcern
        extend ActiveSupport::Concern
        
        included do
          before_action(only: :paper_trails_index) { load_resource; load_versions }
          before_action(only: :paper_trails_show) { load_resource; load_version }
          before_action(only: :paper_trails_show_at) { load_resource; load_version_by_timestamp }
        end

        def paper_trails_index
        end

        def paper_trails_show
        end

        def paper_trails_show_at
        end

        private

        def load_versions
          @versions = @resource.versions
        end

        def load_version
          @version = @resource.versions.find(params[:version_id])
          @resource = @version.reify
        end

        def load_version_by_timestamp
          timestamp = DateTime.parse(params[:version_at])
          @version = @resource.versions.subsequent(timestamp, true).first
          @resource = @version&.reify || @resource
          render :paper_trails_show
        end
      end
    end
  end
end
