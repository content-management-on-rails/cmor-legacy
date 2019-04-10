module Cmor
  module Testimonials
    class ViewComponent
      include ActiveModel::Model

      attr_accessor :context
      attr_accessor :options
      validates_presence_of :context

      def render
        context.render(
          partial: "components/#{template_path}",
          locals: { component: self, options: options }
        )
      end

      def options
        @options || {}
      end

      private

      def template_path
        self.class.to_s.underscore
      end
    end
  end
end