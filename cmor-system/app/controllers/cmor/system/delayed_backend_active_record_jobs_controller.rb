module Cmor
  module System
    class DelayedBackendActiveRecordJobsController < Cmor::Core::Backend::ResourcesController::Base
      def self.resource_class
        ::Delayed::Backend::ActiveRecord::Job
      end

      def self.available_rest_actions
        %i[index show edit update destroy]
      end

      private

      def permitted_params
        params.require(:delayed_backend_active_record_job).permit(:priority, :attempts, :handler, :last_error, :run_at, :locked_at, :failed_at, :locked_by, :queue)
      end
    end
  end
end
