module ActionView::Template::Handlers
  class Textile
    class_attribute :default_format
    self.default_format = Mime[:html]

    def erb_handler
      @@erb_handler ||= ActionView::Template.registered_template_handler(:erb)
    end

    # def call(template, source)
    #   compiled_source = erb_handler.call(template, source)
    #   "RedCloth.new(begin;#{compiled_source};end).to_html.html_safe"
    # end
    if Rails.version < '6.0.0.beta2'
      def call(template)
        compiled_source = erb_handler.call(template)
        "RedCloth.new(begin;#{compiled_source};end).to_html.html_safe"
      end
    else
      def call(template, source)
        compiled_source = erb_handler.call(template, source)
        "RedCloth.new(begin;#{compiled_source};end).to_html.html_safe"
      end
    end
  end
end
