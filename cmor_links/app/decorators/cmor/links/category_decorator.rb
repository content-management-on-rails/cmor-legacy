module Cmor::Links
  class CategoryDecorator < Draper::Decorator
    delegate_all

    def links_count_label
      h.content_tag(:span, cmor_links_links_count, class: 'badge')
    end

    def locale_label
      h.content_tag(:span, locale, class: 'label label-info')
    end

    def tree_name
      name
    end
  end
end
