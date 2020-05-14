module Cmor
  module Cms
    class LayoutResolver < TemplateResolver
      def template_class
        'Cmor::Cms::Layout'
      end
    end
  end
end
