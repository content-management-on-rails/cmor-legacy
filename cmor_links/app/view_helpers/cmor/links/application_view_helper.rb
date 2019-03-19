module Cmor
  module Links
    class ApplicationViewHelper < Rao::ViewHelper::Base
      def render_footer(categories = nil, _options = {})
        categories = categories || Cmor::Links::Category.for_link_footer.all
        grouped_categories = categories.group_by(&:link_footer_column)
        c.render partial: 'cmor/links/application_view_helper/render_footer', locals: { categories: grouped_categories }
      end
    end
  end
end
