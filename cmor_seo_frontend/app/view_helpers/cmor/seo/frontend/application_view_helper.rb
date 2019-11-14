# frozen_string_literal: true

module Cmor::Seo
  module Frontend
    # Example:
    #
    #     # app/controllers/application_controller.rb
    #     class ApplicationController < ActionController::Base
    #       view_helper Cmor::Seo::Frontend::ApplicationViewHelper, as: :seo_helper
    #     end
    #
    class ApplicationViewHelper < Rao::ViewHelper::Base
      def render_meta_tags
        item = find_item

        if item.present?
          @meta_tags = item.meta_tags.published
          render meta_tags: @meta_tags
        end
      end

      private
        def find_item
          if item = find_item_by_path(c.request.path)
            return item
          end

          if c.respond_to?(:resource_class) && c.instance_variable_get(:@resource).nil?
            raise "not implemented"
            return
          end

          if c.respond_to?(:resource_class) && c.instance_variable_get(:@resource).present?
            resource = c.instance_variable_get(:@resource)
            return Cmor::Seo::Item.where(resource_type: resource.class.name, resource_id: resource.id).published.first
          end

          if c.controller.class.name == "Cmor::Cms::PageController" && c.params.has_key?(:page)
            return find_item_by_page(c.params[:page])
          end
        end

        def find_item_by_page(page_name)
          page = Cmor::Cms::Page.where(pathname: "/#{page_name.split('/')[0..-2].join('/')}", basename: page_name.split("/").last, locale: I18n.locale, format: :html).first
          if page.present?
            Cmor::Seo::Item.where(resource_type: page.class.name, resource_id: page.id).published.first
          else
            nil
          end
        end

        def find_item_by_path(path)
          Cmor::Seo::Item.where(path: path).published.first
        end
    end
  end
end
