module Cmor
  module Cms
    class LayoutResolver < TemplateResolver
      def template_class
        'Cmor::Cms::Layout'
      end

      def assert_slashs(prefix)
        output = prefix.dup
        output << '/' unless output.end_with?('/')
        # output = '/' << output unless output.start_with?('/')
        output
      end
    end
  end
end
