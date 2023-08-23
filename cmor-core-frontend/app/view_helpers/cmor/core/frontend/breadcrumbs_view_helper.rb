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
        include Cmor::Core::Frontend::Breadcrumb::I18nConcern
        # Usage:
        #
        #     # app/views/layouts/application.html.erb
        #     %html
        #       %body
        #         = breadcrumbs_helper(self).render_breadcrumbs
        #
        # Excluding elements:
        #
        # You can exclude breadcrumbs by passing the exclude option by index or :last or :first:
        #
        #     = breadcrumbs_helper(self).render_breadcrumbs(exclude: :first)
        #
        # You can configure the first breadcrumb in the initializer by setting the first_breadcrumb options.
        #
        def render_breadcrumbs(options = {})
          options.reverse_merge!(exclude: [])
          exclude = options.delete(:exclude)
          breadcrumbs = [].tap do |b|
            # Add breadcrumb to home page
            b.push(instance_exec(&Cmor::Core::Frontend::Configuration.first_breadcrumb))

            # Are custom breadcrumbs defined?
            if custom_breadcrumbs.any?
              b.push << custom_breadcrumbs
              exclude = []
              next
            end

            # Are we showing a cms page?
            if c.controller.class.name == 'Cmor::Cms::PageController' && c.action_name == 'respond' && c.params[:page] != 'home'
              # Add breadcrumb for this page
              b.push(Cmor::Core::Frontend::Breadcrumb::Base.new(label: c.content_for(:title), url: c.url_for()))
            end

            # Are we inside an engine with a root route?
            if c.controller.respond_to?(:current_engine, true)
              # Add a text breadcrumb for the current engine
              b.push(breadcrumb_for_current_engine)
            end

            # Are we inside a resources controller?
            if c.controller.class.respond_to?(:resource_class)
              # Add a breadrumb for collection page
              begin
                b.push(Cmor::Core::Frontend::Breadcrumb::Base.new(label: c.controller.class.resource_class.model_name.human(count: :other), url: c.url_for(action: :index, page: nil)))
              rescue ActionController::UrlGenerationError => e
                b.push(Cmor::Core::Frontend::Breadcrumb::Base.new(label: c.controller.class.resource_class.model_name.human(count: :other), url: nil))
                Rails.logger.debug "[Cmor::Core::Frontend] Could not generate url for #{c.controller.class.resource_class.model_name.human(count: :other)} index page. Continuing without this breadcrumb."
              end

              # Are we showing a single resource?
              if r = c.instance_variable_get(:@resource).presence
                # Is it persisted?
                if r.persisted?
                  # Add breadcrumb to this specific resource
                  begin
                    b.push(Cmor::Core::Frontend::Breadcrumb::Base.new(label: label_for(r), url: c.url_for(action: :show, id: r.to_param)))
                  rescue ActionController::UrlGenerationError => e
                    Rails.logger.debug "[Cmor::Core::Frontend] Could not generate url for #{r.class.name} #{r.to_param}. Continuing without this breadcrumb."
                  end
                end
              end

              # Are we showing the collection (index) page?
              if r = c.instance_variable_get(:@collection).presence
                # Are we paginating?
                if c.params.has_key?(:page)
                  # Add breadcrumb for this page
                  b.push(Cmor::Core::Frontend::Breadcrumb::Base.new(label: c.controller.class.resource_class.model_name.human(count: :other), url: c.url_for()))
                end
              end

              # Are we showing the new page?
              if c.action_name == 'new'
                # Add breadcrumb for this page
                b.push(Cmor::Core::Frontend::Breadcrumb::Base.new(label: I18n.t('cmor.core.frontend.breadcrumbs.new'), url: nil))
              end
            end

            # Are we inside a service controller?
            if c.controller.class.respond_to?(:service_class)
              # Add a text breadcrumb for the service name
              b.push(Cmor::Core::Frontend::Breadcrumb::Base.new(label: c.controller.class.service_class.model_name.human))
            end
          end

          breadcrumbs.flatten!
          breadcrumbs.last.url = nil

          if exclude.any?
            if exclude.include?(:last)
              breadcrumbs.pop
            end
            exclude.keep_if{ |e| e.is_a?(Integer) }.sort.reverse.each { |index| breadcrumbs.delete_at(index) }
            if exclude.include?(:first)
              breadcrumbs.shift
            end
          end

          if c.controller.respond_to?(:breadcrumbs, true)
            breadcrumbs = c.controller.send(:breadcrumbs, breadcrumbs)
          end

          render breadcrumbs: breadcrumbs
        end

        private

        def custom_breadcrumbs
          klass = custom_breadcrumb_path_class
          if klass.present?
            klass.new(context: c).breadcrumbs
          else
            []
          end
        end

        def custom_breadcrumb_path_class
          klass_name = "#{c.controller.class.name}::#{c.action_name.camelize}BreadcrumbPath"
          # Are we eager loading?
          if Rails.application.config.eager_load
            # If so we can ask const_defined?
            if klass_name.split("::")[0...-1].join("::").constantize.const_defined?(klass_name.split("::").last)
              klass_name.constantize
            end
          else
            # Else we have to try to constantize the klass name to see if it lazy loads.
            begin
              klass_name.constantize
            rescue NameError => e
              Rails.logger.debug "No custom breadcrumb path class found. Define #{klass_name} to customize breadcrumbs. Continuing with default breadcrumbs."
              nil
            end
          end
        end

        def breadcrumb_for_current_engine
          breadcrumb_for_engine(current_engine)
        end

        def breadcrumb_for_engine(engine)
          router_name = engine.name.underscore.gsub("/", "_").gsub(/_engine$/, '')
          url = c.send("#{router_name}").root_path
          Cmor::Core::Frontend::Breadcrumb::Base.new(label: I18n.t("classes.#{engine.name.underscore}"), url: url)
        end

        def current_engine
          if c.controller.respond_to?(:current_engine, true)
            return c.controller.send(:current_engine)
          end
          klass_name_parts = c.controller.class.name.split("::")
          klass_name_parts.size.downto(1).each do |i|
            if klass_name_parts.take(i).join("::").constantize.const_defined?("Engine")
              break [klass_name_parts.take(i), ['Engine']].flatten.join("::").constantize
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
