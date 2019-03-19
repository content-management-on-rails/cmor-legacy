class TagListRenderer < ResourceRenderer::AttributeRenderer::Base
  def display(attribute_name, _label, _options = {}, &_block)
    tag_list = value_for_attribute(attribute_name)
    output = tag_list.collect do |tag|
      h.content_tag(:span, tag, class: 'label label-default')
    end.join('&nbsp;').html_safe
  end
end
