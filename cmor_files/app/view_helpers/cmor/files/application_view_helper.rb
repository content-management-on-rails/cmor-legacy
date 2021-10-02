module Cmor
  module Files
    # Example:
    #
    #     # app/controllers/application_controller.rb
    #     class ApplicationController < ActionController::Base
    #       view_helper Cmor::Files::ApplicationViewHelper, as: :files_helper
    #     end
    #
    class ApplicationViewHelper < Rao::ViewHelper::Base
      # Example:
      #
      #     # app/views/layouts/application.html.haml
      #     = files_helper(self).render_file(identifier: 'Quick reference manual')
      #
      def render_file(identifier:)
        resource = Cmor::Files::FileDetail.published.where(identifier: identifier).first
        if resource.nil?
          "Could not find published file detail with identifier: '#{identifier}'."
        else
          render resource: resource
        end
      end

      # Example:
      #
      #     # app/views/layouts/application.html.haml
      #     = files_helper(self).render_folder(identifier: 'Manuals')
      #
      def render_folder(identifier:)
        resource = Cmor::Files::Folder.published.where(identifier: identifier).first
        if resource.nil?
          "Could not find published folder with identifier: '#{identifier}'."
        else
          render resource: resource
        end
      end

      def asset_download_button_label(asset)
        "#{c.t(".download")} (#{build_label(asset)}, #{c.number_to_human_size(asset.blob.byte_size)})"
      end

      private

      def build_label(asset)
        type = asset.blob.content_type.split('/').last
        case type
        when 'vnd.openxmlformats-officedocument.spreadsheetml.sheet'
          "xls"
        else
          type
        end
      end
    end
  end
end
