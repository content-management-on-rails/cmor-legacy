# frozen_string_literal: true

module Cmor
  module Audits
    module ResourcesController
      module PaperTrailConcern
        extend ActiveSupport::Concern

        included do
          before_action(only: :versions) { load_resource; load_versions }
          before_action(only: :version) { load_resource; load_version }
          before_action(only: :version_at) { load_resource; load_version_by_timestamp }
        end

        def versions
        end

        def version
        end

        def version_at
          render :version
        end

        private
        def load_versions
          @versions = @resource.versions
        end

        def load_version
          @version = @resource.versions.find(params[:version_id])
          @resource = @version&.reify || @resource
        end

        def load_version_by_timestamp
          timestamp = begin
            DateTime.parse(params[:version_at])
          rescue TypeError
            Time.zone.now
          end

          @version = @resource.versions.subsequent(timestamp, true).first
          @resource = @version&.reify || @resource
        end
      end
    end
  end
end
