module ActionView
  module TemplatePatch
    def self.included(base)
      base.class_eval do
        attr_accessor :layout

        alias_method :original_initialize, :initialize

        if Rails.version < '6.0'
          def initialize(source, identifier, handler, details)
            @layout = details[:layout] if details.key?(:layout)
            original_initialize(source, identifier, handler, details)
          end
        else
          def initialize(source, identifier, handler, format: nil, variant: nil, locals: nil, virtual_path: nil, layout: nil)
            @layout = layout
            original_initialize(source, identifier, handler, format: format, variant: variant, locals: locals, virtual_path: virtual_path)
          end
        end
      end
    end
  end
end

ActionView::Template.send(:include, ActionView::TemplatePatch)
