module Cmor::Rbac
  module Backend
    class ImportDefaultPermissionsServiceController < Cmor::Core::Backend::ServiceController::Base
      before_action :load_filenames, only: [:new, :create]

      def self.service_class
        Cmor::Rbac::ImportDefaultPermissionsService
      end

      private

      def permitted_params
        params.require(:import_default_permissions_service).permit(:filename)
      end

      def load_filenames
        @filenames = ::Rails::Engine.subclasses.map(&:instance).collect do |engine|
          filename = engine.root.join *%w(config rbac.yml)
          next unless File.readable? filename
          filename
        end.compact

        @filenames << application_filename if File.readable? application_filename
      end

      def application_filename
        Rails.root.join *%w(config rbac.yml)
      end
    end
  end
end
