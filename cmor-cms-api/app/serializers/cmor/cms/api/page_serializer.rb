module Cmor::Cms::Api
  class PageSerializer < Cmor::Core::Api::Serializer::Base
    def as_json
      super.tap do |hash|
        hash[:attributes].merge!(html: html)
      end
    end

    def html
      return unless [ 'html', '', nil ].include?(@resource.format)
      rendered = ApplicationController.render(
        inline: @resource.body,
      )
      if @resource.handler == 'textile'
        RedCloth.new(rendered).to_html
      else
        rendered
      end
    end
  end
end
