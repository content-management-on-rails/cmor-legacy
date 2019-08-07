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

            # Are we showing a cms page?
            if c.controller.class.name == 'Cmor::Cms::PageController' && c.action_name == 'respond' && c.params[:page] != 'home'
              # Add breadcrumb for this page
              b.push(Cmor::Core::Frontend::Breadcrumb::Base.new(label: c.content_for(:title), url: c.url_for()))
            end

            # Are we inside a resources controller?
            if c.controller.class.respond_to?(:resource_class)
              # Add a text breadcrumb for the current engine
              b.push(breadcrumb_for_current_engine)

              # Add a breadrumb for collection page
              b.push(Cmor::Core::Frontend::Breadcrumb::Base.new(label: c.controller.class.resource_class.model_name.human(count: :other), url: c.url_for(action: :index, page: nil)))

              # Are we showing a single resource?
              if r = c.instance_variable_get(:@resource).presence
                # Is it persisted?
                if r.persisted?
                  # Add breadcrumb to this specific resource
                  b.push(Cmor::Core::Frontend::Breadcrumb::Base.new(label: label_for(r), url: c.url_for(action: :show, id: r.to_param)))
                end
              end

              # Are we showing the collection (index) page?
              if r = c.instance_variable_get(:@collection).presence
                # Are we paginating?
                if c.params.has_key?(:page)
                  # Ass breadcrumb for this page
                  b.push(Cmor::Core::Frontend::Breadcrumb::Base.new(label: c.controller.class.resource_class.model_name.human(count: :other), url: c.url_for()))
                end
              end
            end

            # Are we inside a service controller?
            if c.controller.class.respond_to?(:service_class)
              # Add a text breadcrumb for the engine
              b.push(breadcrumb_for_current_engine)

              # Add a text breadcrumb for the service name
              b.push(Cmor::Core::Frontend::Breadcrumb::Base.new(label: c.controller.class.service_class.model_name.human))
            end
          end

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

          render breadcrumbs: breadcrumbs
        end

        private

        def breadcrumb_for_current_engine
          return if current_engine.nil?
          breadcrumb_for_engine(current_engine)
        end

        def breadcrumb_for_engine(engine)
          Cmor::Core::Frontend::Breadcrumb::Base.new(label: I18n.t("classes.#{engine.name.underscore}"))
        end

        def current_engine
          klass_name_parts = c.controller.class.name.split("::")
          klass_name_parts.size.downto(1).each do |i|
            if klass_name_parts.take(i).join("::").constantize.const_defined?("Engine")
              break [klass_name_parts.take(i), ['Engine']].flatten.join("::").constantize
            end
          end
        end

        def t(identifier, options = {})
          if identifier.start_with?('.')
            prefix = self.class.name.underscore

            # Check if we are in a proc by matching the caller string
            caller_method = if caller[0] =~ /\(required\)>/
              # If yes omit the last call (that has to be instance_exec) and
              # fetch the previous one that should be the method that is really
              # calling us.
              caller[2].split(' ').last.gsub("'", '').gsub("`", '')
            else
              # Otherwise take the first caller
              caller[0].split(' ').last.gsub("'", '').gsub("`", '')
            end

            I18n.t("#{prefix}.#{caller_method}.#{identifier}", options)
          else
            I18n.t(identifier, options)
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
