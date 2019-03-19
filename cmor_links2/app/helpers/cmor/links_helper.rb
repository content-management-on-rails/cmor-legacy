module Cmor::LinksHelper
  def render_link_footer(categories = nil, _options = {})
    categories = Cmor::Links::Category.for_link_footer.all if categories.nil?
    grouped_categories = categories.group_by(&:link_footer_column)
    render(partial: 'cmor/links/link_footer', locals: { categories: grouped_categories })
  end
end
