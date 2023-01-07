module ActionView
  module TemplateRendererPatch
    def self.included(base)
      base.class_eval do
        alias_method :original_render, :render

        def render(context, options)
          @details = extract_details(options)
          template = determine_template(options)

          prepend_formats(template.format)

          layout = (template.respond_to?(:layout) ? template.layout : nil) || options[:layout]
          render_template(context, template, (layout || options[:layout]), options[:locals] || {})
        end
      end
    end
  end
end

ActionView::TemplateRenderer.send(:include, ActionView::TemplateRendererPatch)
