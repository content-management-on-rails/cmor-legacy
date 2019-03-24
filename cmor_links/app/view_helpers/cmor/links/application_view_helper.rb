module Cmor
  module Links
    class ApplicationViewHelper < Rao::ViewHelper::Base
      def render_footer(categories = nil)
        categories = categories || Cmor::Links::Category.for_link_footer.all
        grouped_categories = categories.group_by(&:link_footer_column)
        c.render partial: 'cmor/links/application_view_helper/render_footer', locals: { categories: grouped_categories }
      end

      def render_category(category)
        c.render partial: "cmor/links/categories/category", locals: { category: category }
      end
      
      def render_link(link)
        c.render partial: "cmor/links/links/link", locals: { link: link }
      end
    end
  end
end
