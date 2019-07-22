module Cmor
  module Core
    module Frontend
      # Usage:
      #
      #
      #     # app/controllers/application_controller.rb
      #     class ApplicationController < ActionController::Base
      #       view_helper Cmor::Core::Frontend::BreadcrumbsViewHelper, as: :breadcrumbs_helper
      #     end
      #
      class BreadcrumbsViewHelper < Rao::ViewHelper::Base
        # Usage:
        #
        #     # app/views/layouts/application.html.erb
        #     %html
        #       %body
        #         = breadcrumbs_helper(self).render_breadcrumbs
        #
        def render_breadcrumbs
          breadcrumbs = [].tap do |b|
            # Add breadcrumb to home page
            b.push(Breadcrumb.new(label: t('.home'), url: c.main_app.root_path))

            # Are we showing a cms page?
            if c.controller.class.name == 'Cmor::Cms::PageController' && c.action_name == 'respond' && c.params[:page] != 'home'
              # Add breadcrumb for this page
              b.push(Breadcrumb.new(label: c.content_for(:title), url: c.url_for()))
            end

            # Are we inside a resources controller?
            if c.controller.class.respond_to?(:resource_class)
              # Add a breadrumb for collection page
              b.push(Breadcrumb.new(label: c.controller.class.resource_class.model_name.human(count: :other), url: c.url_for(action: :index, page: nil)))

              # Are we showing a single resource?
              if r = c.instance_variable_get(:@resource).presence
                # Is it persisted?
                if r.persisted?
                  # Add breadcrumb to this specific resource
                  b.push(Breadcrumb.new(label: label_for(r), url: c.url_for(action: :show, id: r.to_param)))
                end
              end

              # Are we showing the collection (index) page?
              if r = c.instance_variable_get(:@collection).presence
                # Are we paginating?
                if c.params.has_key?(:page)
                  # Ass breadcrumb for this page
                  b.push(Breadcrumb.new(label: c.controller.class.resource_class.model_name.human(count: :other), url: c.url_for()))
                end
              end
            end
          end
          breadcrumbs.last.url = nil
          render breadcrumbs: breadcrumbs
        end

        def t(identifier, options = {})
          if identifier.start_with?('.')
            prefix = self.class.name.underscore
            caller_method = caller[0].split(' ').last.gsub("'", '')
            I18n.t("#{prefix}.#{caller_method}.#{identifier}", options)
          else
            I18n.t(identifier, options)
          end
        end

        class Breadcrumb
          extend ActiveModel::Model

          attr_accessor :label, :url, :link_html_options, :li_html_options
          
          def initialize(attrs)
            attrs.reverse_merge!(link_html_options: {}, li_html_options: {})
            attrs.each do |k, v|
              self.send("#{k}=", v)
            end
          end
        end

        private

        def label_for(resource)
          Cmor::Core::Frontend::Configuration.resource_label_methods.each do |method_name|
            next unless resource.respond_to?(method_name)
            return resource.send(method_name)
          end
        end
      end
    end
  end
end
